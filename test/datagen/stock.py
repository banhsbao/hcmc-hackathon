import datetime
import json
import random
import boto3
import time

STREAM_NAME = "hcmc-hackathon-stream"
STREAM_REGION = "ap-southeast-1"


def get_data():
    return {
        "event_time": datetime.datetime.now().isoformat(),
        "node_id": random.choice(
            [
                "NODE_SG_01",
                "NODE_SG_02",
                "NODE_SG_03",
                "NODE_SG_04",
                "NODE_SG_05",
                "NODE_SG_06",
                "NODE_SG_07",
                "NODE_SG_08",
                "NODE_SG_09",
                "NODE_SG_10",
            ]
        ),
        "ph": random.randint(1, 20),
        "tds": random.randint(50, 500),
    }


def generate(stream_name, kinesis_client):
    while True:
        data = get_data()
        print(data)
        kinesis_client.put_record(
            StreamName=stream_name, Data=json.dumps(data), PartitionKey="partitionkey"
        )


if __name__ == "__main__":
    generate(STREAM_NAME, boto3.client("kinesis", region_name=STREAM_REGION))
