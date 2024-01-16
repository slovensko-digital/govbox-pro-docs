FROM node:18-alpine AS base

RUN apk add --no-cache libc6-compat npm
WORKDIR /app

# Install dependencies based on the preferred package manager
COPY package.json package-lock.json* ./
RUN npm install

ENV NODE_ENV production

COPY . .
RUN yarn build

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs
USER nextjs

EXPOSE 3000
ENV PORT 3000

CMD ["yarn", "start"]
