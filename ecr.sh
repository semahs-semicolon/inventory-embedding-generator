#!/bin/bash
aws ecr-public get-login-password --region us-east-1 --profile semicolon-inventory | docker login --username AWS --password-stdin public.ecr.aws
aws ecr get-login-password --region ap-northeast-2 --profile semicolon-inventory | docker login --username AWS --password-stdin 767397837757.dkr.ecr.ap-northeast-2.amazonaws.com
docker build . -t 767397837757.dkr.ecr.ap-northeast-2.amazonaws.com/embeddinggen:v1
docker push 767397837757.dkr.ecr.ap-northeast-2.amazonaws.com/embeddinggen:v1
