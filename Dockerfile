# syntax=docker/dockerfile:1
FROM jenkins/inbound-agent
USER root
RUN apt-get update; \
apt-get install -y wget; \
wget https://download.docker.com/linux/static/stable/x86_64/docker-20.10.9.tgz; \
tar zxvf docker-20.10.9.tgz; \
cp -f docker/docker /usr/local/bin; \
rm -fr docker-20.10.0.tgz docker; \
apt-get purge -y wget

FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
