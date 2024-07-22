#!/bin/bash

aws ecr get-login-password --region ap-northeast-2 --profile semicolon-inventory-test | docker login --username AWS --password-stdin 851725607847.dkr.ecr.ap-northeast-2.amazonaws.com
docker build . -t 851725607847.dkr.ecr.ap-northeast-2.amazonaws.com/embeddinggen:v6
docker push 851725607847.dkr.ecr.ap-northeast-2.amazonaws.com/embeddinggen:v6
