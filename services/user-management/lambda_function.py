import boto3
from datetime import datetime
import geohash2
from boto3.dynamodb.conditions import Key

dynamodb = boto3.client("dynamodb")
tableName = "angelhack-users"
notifications_table = "angelhack-notify"


def save_user_information(user_id, name, phone, email):
    try:
        response = dynamodb.get_item(
            TableName=tableName, Key={"userId": {"S": user_id}}
        )
        if "Item" in response:
            print(f"User with userId {user_id} already exists.")
        else:
            response = dynamodb.put_item(
                TableName=tableName,
                Item={
                    "userId": {"S": user_id},
                    "name": {"S": name},
                    "phone": {"S": phone},
                    "email": {"S": email},
                },
            )
            print(f"User information saved for userId {user_id}: {response}")
    except Exception as e:
        print(f"Error saving user information for userId {user_id}: {e}")


def save_user_location(user_id, latitude, longitude):
    try:
        precision = 6
        geohash_code = geohash2.encode(latitude, longitude, precision)
        response = dynamodb.update_item(
            TableName=tableName,
            Key={"userId": {"S": user_id}},
            UpdateExpression="SET gps = :g, #ts = :t",
            ExpressionAttributeValues={
                ":g": {"S": geohash_code},
                ":t": {"S": datetime.now().isoformat()},
            },
            ExpressionAttributeNames={"#ts": "timestamp"},
            ReturnValues="UPDATED_NEW",
        )
        print(f"Location updated for userId {user_id}: {response}")
    except Exception as e:
        print(f"Error updating location for userId {user_id}: {e}")


def update_device_token(user_id, device_token):
    try:
        response = dynamodb.update_item(
            TableName=tableName,
            Key={"userId": {"S": user_id}},
            UpdateExpression="SET deviceToken = :d, #ts = :t",
            ExpressionAttributeValues={
                ":d": {"S": device_token},
                ":t": {"S": datetime.now().isoformat()},
            },
            ExpressionAttributeNames={"#ts": "timestamp"},
            ReturnValues="UPDATED_NEW",
        )
        print(f"Device token updated for userId {user_id}: {response}")
    except Exception as e:
        print(f"Error updating device token for userId {user_id}: {e}")


def get_notifications(user_id):
    try:
        response = dynamodb.scan(
            TableName=notifications_table,
            ScanFilter={
                "userId": {
                    "AttributeValueList": [{"S": user_id}],
                    "ComparisonOperator": "EQ",
                }
            },
        )
        items = response.get("Items", [])
        return items
    except Exception as e:
        print(f"Error getting notifications for userId {user_id}: {e}")
        return []


def lambda_handler(event, context):
    action = event["action"]
    user_id = event["userId"]

    if action == "save_information":
        name = event.get("name", "")
        phone = event.get("phone", "")
        email = event.get("email", "")
        save_user_information(user_id, name, phone, email)
    elif action == "save_location":
        latitude = event.get("latitude", "")
        longitude = event.get("longitude", "")
        save_user_location(user_id, latitude, longitude)
    elif action == "update_device_token":
        device_token = event.get("deviceToken", "")
        update_device_token(user_id, device_token)
    elif action == "get_notifications":
        get_notifications(user_id)
    else:
        print(f"Unknown action: {action}")
