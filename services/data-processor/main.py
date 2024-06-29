import boto3
import json
import logging
import pandas as pd
import pickle
from concurrent.futures import ThreadPoolExecutor, as_completed
from botocore.exceptions import NoCredentialsError, PartialCredentialsError
from sklearn.ensemble import IsolationForest
from sklearn.cluster import DBSCAN
import time

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)
logger = logging.getLogger(__name__)

STREAM_NAME = "hcmc-hackathon-stream"
STREAM_REGION = "ap-southeast-1"
NodesDataSyncLambdaARN = (
    "arn:aws:lambda:ap-southeast-1:282679431619:function:HCMHackathonNodesDataSync"
)

kinesis_client = boto3.client("kinesis", region_name=STREAM_REGION)
lambda_client = boto3.client("lambda", region_name=STREAM_REGION)

model_path = "optimized_clf.pkl"
with open(model_path, "rb") as model_file:
    iso_forest_model = pickle.load(model_file)


def monitor_node_status(
    new_data, iso_forest_model, dbscan_eps=1.5, dbscan_min_samples=10
):
    new_data = pd.DataFrame(new_data)
    new_data["anomaly"] = iso_forest_model.predict(new_data[["ph", "tds"]])
    contaminated_nodes = new_data[new_data["anomaly"] == -1]["node_id"].unique()
    db = DBSCAN(eps=dbscan_eps, min_samples=dbscan_min_samples).fit(
        new_data[["ph", "tds"]]
    )
    new_data["cluster"] = db.labels_
    affected_nodes = []
    affected_by = {}

    for node_id in contaminated_nodes:
        node_cluster = new_data[new_data["node_id"] == node_id]["cluster"].iloc[0]
        if node_cluster != -1:
            related_nodes = new_data[new_data["cluster"] == node_cluster][
                "node_id"
            ].unique()
            contaminator = node_id
            affected = [
                n
                for n in related_nodes
                if n != contaminator and n not in contaminated_nodes
            ]
            affected_nodes.extend(affected)
            for a in affected:
                affected_by[a] = contaminator

    affected_nodes = list(set(affected_nodes))
    affected_nodes = [node for node in affected_nodes if node not in contaminated_nodes]

    results = []
    for node_id in new_data["node_id"].unique():
        node_type = "normal"
        if node_id in contaminated_nodes:
            node_type = "polluted"
        elif node_id in affected_nodes:
            node_type = "risk"

        results.append(
            {
                "node_id": node_id,
                "status": node_type,
                "ph": new_data[new_data["node_id"] == node_id]["ph"].mean(),
                "tds": new_data[new_data["node_id"] == node_id]["tds"].mean(),
            }
        )

    return pd.DataFrame(results)


def invoke_lambda(records):
    try:
        response = lambda_client.invoke(
            FunctionName=NodesDataSyncLambdaARN,
            InvocationType="Event",
            Payload=json.dumps(records),
        )
        logger.info(f"Lambda invoked with response: {response}")
    except Exception as e:
        logger.error(f"Error invoking Lambda: {e}")


record_batch = []
last_invoked_time = time.time()


def process_record(record):
    global record_batch, last_invoked_time
    try:
        payload = json.loads(record["Data"])
        # logger.info(f"Processing record: {payload}")

        new_data = pd.DataFrame(
            [
                {
                    "node_id": payload["node_id"],
                    "ph": payload["ph"],
                    "tds": payload["tds"],
                }
            ]
        )
        node_id = payload["node_id"]
        record_exists = False

        for i, existing_record in enumerate(record_batch):
            if existing_record["node_id"] == node_id:
                record_batch[i] = new_data.to_dict(orient="records")[0]
                record_exists = True
                break

        if not record_exists:
            record_batch.append(new_data.to_dict(orient="records")[0])

        current_time = time.time()

        if current_time - last_invoked_time >= 5:
            last_invoked_time = current_time
            result_df = monitor_node_status(record_batch, iso_forest_model)
            logger.info(f"Node status result: {result_df.to_dict(orient='records')}")
            filtered_result_df = result_df[result_df["status"].notnull()]
            if not filtered_result_df.empty:
                invoke_lambda(filtered_result_df.to_dict(orient="records"))
            polluted_records = result_df[result_df["status"] == "polluted"]
            if not polluted_records.empty:
                print("Polluted records:", polluted_records)

    except Exception as e:
        logger.error(f"Error processing record: {e}")


def get_records_from_shard(shard_id, shard_iterator_type="LATEST"):
    try:
        response = kinesis_client.get_shard_iterator(
            StreamName=STREAM_NAME,
            ShardId=shard_id,
            ShardIteratorType=shard_iterator_type,
        )
        shard_iterator = response["ShardIterator"]

        while True:
            response = kinesis_client.get_records(
                ShardIterator=shard_iterator, Limit=100
            )
            records = response["Records"]
            if not records:
                logger.info(f"No records received from shard {shard_id}")
            for record in records:
                process_record(record)
            shard_iterator = response["NextShardIterator"]
    except (NoCredentialsError, PartialCredentialsError) as e:
        logger.error(f"Credential error: {e}")
    except Exception as e:
        logger.error(f"Error getting records from shard {shard_id}: {e}")


def main():
    try:
        response = kinesis_client.describe_stream(StreamName=STREAM_NAME)
        stream_status = response["StreamDescription"]["StreamStatus"]
        if stream_status != "ACTIVE":
            logger.error("Stream is not active.")
            return

        shards = response["StreamDescription"]["Shards"]
        with ThreadPoolExecutor(max_workers=len(shards)) as executor:
            futures = {
                executor.submit(get_records_from_shard, shard["ShardId"]): shard[
                    "ShardId"
                ]
                for shard in shards
            }
            for future in as_completed(futures):
                shard_id = futures[future]
                try:
                    future.result()
                except Exception as e:
                    logger.error(f"Error processing shard {shard_id}: {e}")
    except (NoCredentialsError, PartialCredentialsError) as e:
        logger.error(f"Credential error: {e}")
    except Exception as e:
        logger.error(f"Error describing stream: {e}")


if __name__ == "__main__":
    main()
