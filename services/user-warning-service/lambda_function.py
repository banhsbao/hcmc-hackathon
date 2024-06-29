from decimal import Decimal
import json
import boto3
import datetime


dynamodb = boto3.resource("dynamodb")
table_nodes = dynamodb.Table("angelhack-nodes")
table_users = dynamodb.Table("angelhack-users")
lambda_client = boto3.client("lambda")


def get_node_information(table_nodes, key):
    try:
        response = table_nodes.get_item(Key=key)
        item = response.get("Item")
        if item:
            print("Polluted node found:", item)
            return item
        else:
            print("Polluted node not found")
    except Exception as e:
        print(f"Error getting item: {e}")


def save_notification_time(table_users, user_id):
    try:
        response = table_users.update_item(
            Key={"userId": user_id},
            UpdateExpression="SET lastNotificationTime = :time",
            ExpressionAttributeValues={":time": datetime.datetime.now().isoformat()},
            ReturnValues="UPDATED_NEW",
        )
        print("Notification time updated:", response)
    except Exception as e:
        print(f"Error updating notification time: {e}")


def should_notify_user(last_notification_time):
    if not last_notification_time:
        return True
    last_notification_time = datetime.datetime.fromisoformat(last_notification_time)
    current_time = datetime.datetime.now()
    print((current_time - last_notification_time).total_seconds())
    return (current_time - last_notification_time).total_seconds() > 300


def invoke_lambda(messages):
    try:
        payload = json.dumps(
            [
                {
                    "user_id": msg["userId"],
                    "message": {
                        "title": "Water Pollution Alert",
                        "body": msg["message"],
                    },
                }
                for msg in messages
            ]
        )
        response = lambda_client.invoke(
            FunctionName="arn:aws:lambda:ap-southeast-1:282679431619:function:HCMHackathonNotify",
            InvocationType="Event",
            Payload=payload,
        )
        print("Lambda invoked with response:", response)
    except Exception as e:
        print(f"Error invoking lambda: {e}")


def lambda_handler(event, context):
    try:
        node_ids = event.get("nodeIds", [])
        if not node_ids:
            return {
                "statusCode": 400,
                "body": json.dumps({"message": "No nodeIds provided"}),
            }

        all_messages = []

        for node_id in node_ids:
            example_key = {"nodeId": node_id}

            node_item = get_node_information(table_nodes, example_key)
            if not node_item:
                all_messages.append(f"Node {node_id} not found")
                continue

            gps_of_node = node_item["gps"]

            try:
                response = table_users.scan(
                    ProjectionExpression="userId, #nm, gps",
                    FilterExpression=boto3.dynamodb.conditions.Attr("gps").begins_with(
                        gps_of_node
                    ),
                    ExpressionAttributeNames={"#nm": "name"},
                )
                users = response.get("Items", [])
                if not users:
                    all_messages.append(
                        {
                            "userId": "unknown",
                            "message": f"No users found for node {node_id}",
                        }
                    )
                    continue

                for user in users:
                    if should_notify_user(user.get("lastNotificationTime")):
                        message = f"Hi {user['name']}, the water near you is currently polluted. Please be careful!"
                        all_messages.append(
                            {"userId": user["userId"], "message": message}
                        )
                        save_notification_time(table_users, user["userId"])
                    else:
                        print(f"User {user['userId']} notified recently. Skipping.")

            except Exception as e:
                all_messages.append(f"Error processing node {node_id}: {str(e)}")

        if all_messages:
            invoke_lambda(all_messages)

        return {"statusCode": 200, "body": json.dumps({"messages": all_messages})}

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps(
                {"message": "Error processing request", "error": str(e)}
            ),
        }

