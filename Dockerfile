FROM strider/strider-docker-slave
USER root
ADD /sudoers.txt /etc/sudoers
RUN chmod 440 /etc/sudoers
RUN  apt-get update \
  && apt-get install -y wget \
  python-pip \
  openjdk-7-jdk \
  python-virtualenv \
  postgresql-devel
ADD http://apache.lauf-forum.at/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz /opt/
RUN cd /opt/ && tar -xvf ./spark-1.5.2-bin-hadoop2.6.tgz
