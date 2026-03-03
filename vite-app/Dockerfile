FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git

RUN apt-get update && apt-get install -y \
    python3-dev \
    nano \
    && rm -rf /var/lib/apt/lists/*

ARG REPO_URL
RUN git clone $REPO_URL .

RUN npm install
RUN npm run build

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host"]