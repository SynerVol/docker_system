FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    nano \
    && rm -rf /var/lib/apt/lists/*

ARG REPO_URL
RUN git clone $REPO_URL .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["python", "main.py"]