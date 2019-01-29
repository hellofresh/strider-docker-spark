FROM strider/strider-docker-slave
USER root
ADD /sudoers.txt /etc/sudoers
RUN chmod 440 /etc/sudoers
RUN  apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get install -y wget \
  python-pip \
  openjdk-7-jdk \
  python-virtualenv \
  python-dev \
  libpq-dev \
  build-essential \
  libssl-dev \
  libffi-dev
ADD http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz /opt/
RUN cd /opt/ && tar -xvf ./spark-1.6.1-bin-hadoop2.6.tgz
ADD https://archive.apache.org/dist/spark/spark-2.3.0/spark-2.3.0-bin-hadoop2.6.tgz /opt/
RUN cd /opt/ && tar -xvf ./spark-2.3.0-bin-hadoop2.6.tgz
