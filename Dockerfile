FROM --platform=linux/amd64 public.ecr.aws/lambda/python:3.11

# Copy requirements.txt
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Install the specified packages
RUN pip install -r requirements.txt

RUN mkdir /var/task/.cache
RUN python -c 'from sentence_transformers import SentenceTransformer; embedder = SentenceTransformer("clip-ViT-B-32", cache_folder="/var/task/.cache")'

# Copy function code
COPY main.py ${LAMBDA_TASK_ROOT}

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "main.handler" ]