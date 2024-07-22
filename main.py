import io
import os

import base64
# import requests
import json

from sentence_transformers import SentenceTransformer, util
from PIL import Image


import boto3

s3 = boto3.client('s3')

model = None
def handler(event, context):
    global model
    if model is None:
        print("Loadin clip model")
        model = SentenceTransformer('clip-ViT-B-32', cache_folder="/var/task/.cache")

        print("Loaded clip")
    
    path = event["path"]
    image = None
    body = event["body"]
    if event["isBase64Encoded"]:
        body = base64.b64decode(body)

    if path == 'processs3':
        imageId = json.loads(body)["imageid"]

        bucket = os.getenv("BUCKET")
        result = s3.get_object(Bucket = bucket, Key = imageId)
        contents = result['Body'].read()

        image = Image.open(io.BytesIO(contents))
    elif path == 'process':
        image = Image.open(io.BytesIO(body))

    print(image)

    img_emb = model.encode(image)
    payload = {"embedding": img_emb.tolist()}

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(payload)
    }