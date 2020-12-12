# Base
FROM node:12-alpine as builder

WORKDIR /app

# Dependencies
COPY package*.json ./
RUN npm install && npm cache clean --force

# Build
COPY . .
RUN npm run build && npm prune --production

FROM node:12-alpine
WORKDIR /app
COPY --from=builder /app ./

# Application
USER node
ENV PORT=8080
EXPOSE 8080

CMD ["node", "dist/main.js"]