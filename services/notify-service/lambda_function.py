import boto3
import firebase_admin
import firebase_admin.messaging
from datetime import datetime
import uuid


dynamodb = boto3.client("dynamodb")
tableName = "angelhack-users"
notifications_table = "angelhack-notify"


def initialize_firebase():
    if not firebase_admin._apps:
        cred = firebase_admin.credentials.Certificate(
            "angelhack-c919b-firebase-adminsdk-edwkf-fac3468e52.json"
        )
        firebase_admin.initialize_app(cred)


def get_device_token(user_id):
    try:
        response = dynamodb.get_item(
            TableName=tableName, Key={"userId": {"S": user_id}}
        )
        return response["Item"]["deviceToken"]["S"] if "Item" in response else None
    except Exception as e:
        print(f"Error getting endpoint for userId {user_id}: {e}")
        return None


def send_fcm_notification(user_id, token, title, body, data=None):
    initialize_firebase()
    messaging = firebase_admin.messaging
    message = messaging.Message(
        token=token,
        notification=messaging.Notification(title=title, body=body),
        data=data,
    )
    try:
        response = messaging.send(message)
        save_notification(user_id, title, body, data)
        print("Successfully sent message:", response)
    except Exception as e:
        print("Error sending message:", e)


def save_notification(user_id, title, body, data):
    notify_id = str(uuid.uuid4())
    try:
        response = dynamodb.put_item(
            TableName=notifications_table,
            Item={
                "notifyId": {"S": notify_id},
                "userId": {"S": user_id},
                "timestamp": {"S": datetime.now().isoformat()},
                "title": {"S": title},
                "body": {"S": body},
                "data": {"S": str(data)},
            },
        )
        print(
            f"Notification saved for userId {user_id} with notifyId {notify_id}: {response}"
        )
    except Exception as e:
        print(f"Error saving notification for userId {user_id}: {e}")


def lambda_handler(event, context):
    for record in event:
        user_id = record["user_id"]
        message = record["message"]
        title = message.get("title", "No Title")
        body = message.get("body", "No Body")
        device_token = get_device_token(user_id)
        if device_token:
            print(device_token)
            send_fcm_notification(user_id, device_token, title, body, message)
        else:
            print(f"No endpoint found for userId {user_id}")


# [{"user_id": "banhsbao", "message": {"title": "test", "body": "body"}}]
