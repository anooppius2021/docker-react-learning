FROM node:alpine as builder

# Create app directory
WORKDIR /app
#VOLUME /tmp/appapi

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package.json .

RUN npm install
# If you are building your code for production
#RUN npm install --only=production

# Bundle app source
COPY . .

#EXPOSE 3010
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
