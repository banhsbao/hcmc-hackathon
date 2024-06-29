FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

ENV STREAM_NAME=input-stream
ENV STREAM_REGION=ap-southeast-1

CMD ["python", "main.py"]
