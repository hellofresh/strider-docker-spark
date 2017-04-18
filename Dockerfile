FROM strider/strider-docker-slave
USER root
ADD /sudoers.txt /etc/sudoers
RUN chmod 440 /etc/sudoers
RUN  apt-get update \
  && apt-get install -y wget \
  python-pip \
  openjdk-7-jdk \
  python-virtualenv \
  libpq-dev \
  build-essential \
  libssl-dev \
  libffi-dev 
ADD http://apache.lauf-forum.at/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz /opt/
RUN cd /opt/ && tar -xvf ./spark-1.6.1-bin-hadoop2.6.tgz
