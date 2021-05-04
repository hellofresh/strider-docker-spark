FROM strider/strider-docker-slave
USER root

# Setup workspace and user
RUN addgroup --gid 118 jenkins
RUN adduser --uid 114 --gid 118 --home /home/jenkins --gecos "" jenkins
RUN usermod -a -G root jenkins
RUN mkdir -p /home/jenkins/workspace
RUN chown -R jenkins:jenkins /home/jenkins
RUN chown -R jenkins:jenkins /home/strider

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
  unzip \
  curl \
  libsasl2-dev \
  libsqlite3-dev \
  libbz2-dev
RUN cd /opt/ \
  && wget https://archive.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.6.tgz \
  && tar -xvf ./spark-2.4.0-bin-hadoop2.6.tgz \
  && rm -rf /opt/spark-2.4.0-bin-hadoop2.6.tgz
RUN cd /opt/ \
  && wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz \
  && tar -xvf ./Python-3.7.4.tgz \
  && cd Python-3.7.4 \
  && ./configure \
  && make \
  && make install \
  && rm -rf /opt/Python-3.7.4.tgz

# update pip
RUN pip install --no-cache-dir --upgrade pip==20.3

# install ansible
RUN pip install --no-cache-dir \
        cffi \
        dnspython \
        boto \
        boto3 \
        docopt \
        jinja2 \
        tabulate \
        mandrill \
        elasticsearch \
        netaddr \
        hvac \
        ansible==2.8.2 \
        rsa==4.0 \
        setuptools==44.0.0 \
        google-auth==1.16.0

# install vault
RUN wget -P /tmp/vault https://releases.hashicorp.com/vault/1.1.3/vault_1.1.3_linux_amd64.zip \
    && unzip /tmp/vault/vault_1.1.3_linux_amd64.zip -d /tmp/extract/ \
    && mv /tmp/extract/vault /usr/bin/ \
    && rm -rf /tmp/*

# install anaconda
RUN wget -P /tmp/conda https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh \
    && chmod +x /tmp/conda/Miniconda3-4.5.4-Linux-x86_64.sh\
    && /tmp/conda/Miniconda3-4.5.4-Linux-x86_64.sh -b -u -p /opt/miniconda3 \
    && pip install conda-pack \
    && rm -rf /tmp/*

ADD hellofresh*.yml /home/jenkins

# install awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install -i /.aws/cli

# add permisisons for conda
RUN chmod 777 /home/jenkins/hellofresh*.yml
RUN chown -Rh 114:118 /opt/miniconda3

# create 4 venvs
USER jenkins
RUN . /opt/miniconda3/etc/profile.d/conda.sh \
    && /opt/miniconda3/bin/conda env create -f /home/jenkins/hellofresh-py2.yml \
    && /opt/miniconda3/bin/conda env create -f /home/jenkins/hellofresh-py2-test.yml \
    && /opt/miniconda3/bin/conda env create -f /home/jenkins/hellofresh-py3.yml \
    && /opt/miniconda3/bin/conda env create -f /home/jenkins/hellofresh-py3-test.yml
