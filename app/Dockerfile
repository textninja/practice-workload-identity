FROM node:17
WORKDIR /app
COPY yarn.lock package.json /app/
RUN yarn
COPY . /app
CMD ["yarn", "start"]
