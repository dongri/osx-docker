FROM ubuntu:14.04
MAINTAINER Dongri Jin

RUN apt-get install -y wget && \
    apt-get install -y tar && \
    wget http://nodejs.org/dist/v0.12.7/node-v0.12.7-linux-x64.tar.gz && \
    tar -C /usr/local --strip-components 1 -xzf node-v0.12.7-linux-x64.tar.gz

RUN /usr/local/bin/npm install -g nodemon

RUN mkdir -p /var/app/nodejs

ADD nodejs/package.json /var/app/package.json
# ADD nodejs/nodemon.json /var/app/nodemon.json

RUN cd /var/app && npm install

WORKDIR /var/app/nodejs

EXPOSE 3000

CMD nodemon -L app.js
