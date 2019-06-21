FROM strider/strider-docker-slave
USER root
ADD /sudoers.txt /etc/sudoers
RUN  apt-get update
RUN chmod 440 /etc/sudoers
RUN apt-get install software-properties-common -y
RUN  apt-get update \
  && apt-get install -y wget \
  python-pip \
  openjdk-8-jdk \
  python-virtualenv \
  python-dev \
  libpq-dev \
  build-essential \
  libssl-dev \
  libffi-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN cd /opt/ \
  && wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz \
  && tar -xvf ./spark-1.6.1-bin-hadoop2.6.tgz \
  && rm -rf /opt/spark-1.6.1-bin-hadoop2.6.tgz
RUN cd /opt/ \
  && wget https://archive.apache.org/dist/spark/spark-2.3.0/spark-2.3.0-bin-hadoop2.6.tgz \
  && tar -xvf ./spark-2.3.0-bin-hadoop2.6.tgz \
  && rm -rf /opt/spark-2.3.0-bin-hadoop2.6.tgz
