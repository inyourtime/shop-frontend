FROM node:alpine as deps
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install

FROM node:alpine as builder
WORKDIR /usr/src/app
# ENV NODE_ENV=production
COPY --from=deps /usr/src/app/node_modules ./node_modules
COPY . .
RUN npm run build

FROM node:16-bullseye-slim as runner
WORKDIR /usr/src/app
ADD package.json .
ADD nuxt.config.ts .
# ENV NODE_ENV=production
COPY --from=builder  /usr/src/app/.output ./
# COPY --from=builder /usr/src/app/public ./public
COPY --from=builder /usr/src/app/.nuxt ./.nuxt
EXPOSE 3000
CMD ["npm", "start"]

