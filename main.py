import io
import os

import base64
# import requests

from sentence_transformers import SentenceTransformer, util
from PIL import Image

print("Loadin clip model")
model = SentenceTransformer('clip-ViT-B-32')

print("Loaded clip")

import boto3

s3 = boto3.client('s3')

def handler(event, context):
    path = event["path"]
    image = None
    body = event["body"]
    if event["isBase64Encoded"]:
        body = base64.b64decode(body)

    if path == '/processs3':
        imageId = event["body"]["imageid"]

        bucket = os.getenv("BUCKET")
        result = s3.get_object(Bucket = bucket, Prefix= imageId)
        contents = result['Body'].read()

        image = Image.open(io.BytesIO(contents))
    elif path == 'process':
        image = Image.open(io.BytesIO(body))

    print(image)

    img_emb = model.encode(image)
    payload = {"embedding": img_emb.tolist()}

    return payload