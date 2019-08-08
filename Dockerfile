FROM strider/strider-docker-slave
USER root

# Setup workspace and user
RUN adduser -u 114 -g 118 --home /home/jenkins --gecos "" jenkins
RUN mkdir -p /home/jenkins/workspace
RUN chown -R jenkins /home/jenkins

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
  python3-dev \
  libpq-dev \
  build-essential \
  libssl-dev \
  libffi-dev \
  unzip \
  curl
RUN cd /opt/ \
  && wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.1-bin-hadoop2.6.tgz \
  && tar -xvf ./spark-1.6.1-bin-hadoop2.6.tgz \
  && rm -rf /opt/spark-1.6.1-bin-hadoop2.6.tgz
RUN cd /opt/ \
  && wget https://archive.apache.org/dist/spark/spark-2.3.0/spark-2.3.0-bin-hadoop2.6.tgz \
  && tar -xvf ./spark-2.3.0-bin-hadoop2.6.tgz \
  && rm -rf /opt/spark-2.3.0-bin-hadoop2.6.tgz

# install ansible
RUN pip install cffi \
        dnspython \
        boto \
        boto3 \
        docopt \
        tabulate \
        mandrill \
        elasticsearch \
        netaddr \
        hvac \
        ansible==2.8.2

# install vault
RUN wget -P /tmp/vault https://releases.hashicorp.com/vault/1.1.3/vault_1.1.3_linux_amd64.zip \
    && unzip /tmp/vault/vault_1.1.3_linux_amd64.zip -d /tmp/extract/ \
    && mv /tmp/extract/vault /usr/bin/ \
    && rm -rf /tmp/*


