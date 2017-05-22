FROM debian:wheezy

RUN apt-get update
RUN apt-get install -y dialog
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y dos2unix
RUN apt-get install -y iputils-ping
RUN apt-get install -y net-tools
RUN apt-get install -y sudo
RUN apt-get install -y ca-certificates

ENV MONGO_MAJOR 3.0 
ENV MONGO_VERSION 3.0.15 
ENV MONGO_PACKAGE mongodb-org 


RUN apt-get install -y mongodb-org=3.0.15
RUN apt-get install -y mongodb-org-server=3.0.15  
RUN apt-get install -y mongodb-org-shell=3.0.15
RUN apt-get install -y mongodb-org-mongos=3.0.15 
RUN apt-get install -y mongodb-org-tools=3.0.15 

RUN mkdir -p /data/db /data/configdb \ 
 	&& chown -R mongodb:mongodb /data/db /data/configdb 
VOLUME /data/db /data/configdb

COPY service_start.sh /home/docker/script/service_start.sh
RUN dos2unix /home/docker/script/service_start.sh
RUN chmod 744 /home/docker/script/service_start.sh

ENTRYPOINT /home/docker/script/service_start.sh

EXPOSE 27017 

CMD ["mongod"] 

WORKDIR /home/docker
