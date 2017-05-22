FROM debian:wheezy

RUN apt-get update
RUN apt-get install -y dialog
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y dos2unix
RUN apt-get install -y iputils-ping
RUN apt-get install -y net-tools
RUN apt-get install -y sudo
RUN apt-get install -y ca-certificates

RUN apt-get install -y mongodb-org
RUN apt-get install -y mongodb-org-server 
RUN apt-get install -y mongodb-org-shell
RUN apt-get install -y mongodb-org-mongos
RUN apt-get install -y mongodb-org-tools

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
