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

EXPOSE 8080

#CMD ["python", "mavproxy.py"]
CMD ["python", "backend2.py"]
