FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    libxml2-dev \
    libxslt-dev \
    python3-dev \
    nano \
    && rm -rf /var/lib/apt/lists/*

ARG REPO_URL
RUN git clone $REPO_URL .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 14550
EXPOSE 14551

#CMD ["python", "mavproxy.py"]
#CMD ["python", "/usr/local/bin/mavproxy.py", "--master", "tcp:192.168.1.23:5760", "--master", "tcp:192.168.1.23:5770", "--map", "--console", "--load-module=swarm"]

