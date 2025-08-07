FROM node:18-alpine

WORKDIR /app

COPY . .

RUN npm install

# Install mysql client
RUN apk add --no-cache mysql-client

# Run SQL init before app start
CMD mysql --ssl --ssl-verify-server-cert=FALSE \
    -h "$MYSQL_HOST" \
    -u "$MYSQL_USER" \
    -p"$MYSQL_PASSWORD" \
    "$MYSQL_DATABASE" < init.sql && \
    node index.js
