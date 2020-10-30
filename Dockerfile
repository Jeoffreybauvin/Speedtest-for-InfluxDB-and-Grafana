FROM python:3.7-buster
MAINTAINER Barry Carey <mcarey66@gmail.com>

VOLUME /src/
#COPY influxspeedtest.py requirements.txt config.ini /src/
#ADD influxspeedtest /src/influxspeedtest
WORKDIR /src


RUN apt update && apt install -y ruby && rm -rf /var/lib/apt/lists/*
RUN gem install --no-ri --no-rdoc tiller

COPY . .

RUN pip install -r requirements.txt

ADD /tiller /etc/tiller
COPY docker-entrypoint.sh /
COPY /docker-entrypoint.d/* /docker-entrypoint.d/

ENTRYPOINT [ "/docker-entrypoint.sh", "/usr/local/bin/python", "-u", "/src/influxspeedtest.py"]
