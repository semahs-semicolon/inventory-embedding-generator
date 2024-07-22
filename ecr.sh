#!/bin/bash

aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin aws_account_id.dkr.ecr.region.amazonaws.com
docker build . -t public.ecr.aws/a7j5z8g6/embeddinggenerator:latest
docker push public.ecr.aws/a7j5z8g6/embeddinggenerator:latest
