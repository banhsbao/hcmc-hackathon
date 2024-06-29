import json
import boto3
import datetime
from decimal import Decimal
import logging

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("angelhack-nodes")

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)
logger = logging.getLogger(__name__)


def check_node_exists(node_id):
    try:
        logger.info(f"Checking existence of node with ID: {node_id}")
        response = table.get_item(Key={"nodeId": node_id})
        exists = "Item" in response
        logger.info(f"Node with ID: {node_id} exists: {exists}")
        return exists
    except Exception as e:
        logger.error(
            f"Error checking item existence for node with ID: {node_id}: {str(e)}"
        )
        raise Exception(f"Error checking item existence: {str(e)}")


def update_node(node):
    node_id = node.get("node_id")
    ph = node.get("ph")
    tds = node.get("tds")
    status = node.get("status")

    if not node_id or ph is None or tds is None:
        logger.warning(f"Invalid input for node: {node}")
        return {"node_id": node_id, "status": "failed", "reason": "Invalid input"}

    if not check_node_exists(node_id):
        logger.warning(f"Node with ID: {node_id} does not exist")
        return {"node_id": node_id, "status": "failed", "reason": "Node does not exist"}

    ph = Decimal(ph)
    tds = Decimal(tds)
    update_time = datetime.datetime.now().isoformat()

    try:
        logger.info(f"Updating node with ID: {node_id}")
        table.update_item(
            Key={"nodeId": node_id},
            UpdateExpression="set ph = :p, tds = :t, #s = :status, update_time = :u",
            ExpressionAttributeNames={"#s": "status"},
            ExpressionAttributeValues={
                ":p": ph,
                ":t": tds,
                ":status": status,
                ":u": update_time,
            },
            ReturnValues="UPDATED_NEW",
        )
        logger.info(f"Node with ID: {node_id} successfully updated")
        return {"node_id": node_id, "status": "success"}
    except Exception as e:
        logger.error(f"Error updating node with ID: {node_id}: {str(e)}")
        return {"node_id": node_id, "status": "failed", "reason": str(e)}


def lambda_handler(event, context):
    try:
        logger.info("Received event: %s", json.dumps(event))

        if isinstance(event, list):
            body = event
        elif isinstance(event, dict) and "body" in event:
            body = json.loads(event["body"], parse_float=Decimal)
        else:
            logger.error("Event is not in expected format")
            return {
                "statusCode": 400,
                "body": json.dumps(
                    "Event must be a dictionary with 'body' key or a list of nodes"
                ),
            }

        logger.info(f"Body received: {body}")

        if not isinstance(body, list):
            logger.warning("Invalid input: A list of nodes is required")
            return {
                "statusCode": 400,
                "body": json.dumps("A list of nodes is required"),
            }

        results = [update_node(node) for node in body]

        logger.info(f"Update results: {results}")
        return {
            "statusCode": 200,
            "body": json.dumps(results),
        }
    except json.JSONDecodeError:
        logger.error("Invalid JSON format")
        return {"statusCode": 400, "body": json.dumps("Invalid JSON format")}
    except Exception as e:
        logger.error(f"Server error: {str(e)}")
        return {"statusCode": 500, "body": json.dumps(f"Server error: {str(e)}")}
