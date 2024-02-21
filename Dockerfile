FROM mhart/alpine-node:6.3
ENV NODE_ENV "production"
ENV PORT 8078
EXPOSE 8078
RUN addgroup mygroup && adduser -D -G mygroup myuser && mkdir -p /usr/src/app && chown -R myuser /usr/src/app
RUN npm install -g yarn
USER myuser2

# Prepare app directory
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
COPY yarn.lock /usr/src/app/
RUN yarn install

COPY . /usr/src/app

# Start the app
CMD ["npm", "start"]
