#!/bin/bash

aws ecr get-login-password --region ap-northeast-2 --profile semicolon-inventory | docker login --username AWS --password-stdin 767397837757.dkr.ecr.ap-northeast-2.amazonaws.com
docker build . -t 767397837757.dkr.ecr.ap-northeast-2.amazonaws.com/embeddinggen:v1
docker push 767397837757.dkr.ecr.ap-northeast-2.amazonaws.com/embeddinggen:v1
