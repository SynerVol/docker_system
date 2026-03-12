FROM node:20-alpine

WORKDIR /app

RUN apk add --no-cache git


ARG REPO_URL 
RUN echo -e "cloning ${REPO_URL} or $REPO_URL"
#RUN git clone $REPO_URL .
RUN git clone ${REPO_URL} repo && mv repo/* .

RUN npm install --legacy-peer-deps
RUN npm run build

EXPOSE 5173

CMD ["npm", "run", "dev", "--", "--host"]
