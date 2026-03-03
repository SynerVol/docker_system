FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    gcc \
    python3-dev \
    nano \
    && rm -rf /var/lib/apt/lists/*

ARG REPO_URL
RUN git clone $REPO_URL .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 14550
EXPOSE 14551

CMD ["python", "mavproxy.py"]