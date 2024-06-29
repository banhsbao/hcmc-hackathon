import boto3
from datetime import datetime
import geohash2

dynamodb = boto3.client("dynamodb")
tableName = "angelhack-users"


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
    else:
        print(f"Unknown action: {action}")


# {
#   "action": "save_location",
#   "userId": "banhsbao",
#   "latitude": 37.7749,
#   "longitude": -122.4194
# }

# {
#   "action": "save_information",
#   "userId": "banhsbao",
#   "name": "John Bao",
#   "phone": "123456789",
#   "email": "john.doe@example.com"
# }
