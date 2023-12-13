FROM node:18

WORKDIR /usr/src/app

RUN npm install -g pnpm

COPY package*.json ./

RUN pnpm install

COPY . .

RUN pnpm run build

RUN pnpm test

CMD [ "pnpm", "start" ]
