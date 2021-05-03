FROM python:3.7-alpine

ENV FLAMENCO_OWN_URL localhost:8080
ENV FLAMENCO_MANAGER_NAME "Caiwan's Flamenco Manager"
ENV FLAMENCO_SERVER https://caiwan.hu/

USER root

ENV PYTHONUNBUFFERED=1
RUN apk --update add --no-cache --virtual .build-deps \
    curl

ADD requirements.manager.txt /tmp/requirements.txt
RUN python -m pip install --no-cache-dir --upgrade pip
RUN python -m pip install --no-cache-dir -r /tmp/requirements.txt

# RUN apk del .build-deps
RUN mkdir -p /tmp/manager
RUN curl -o /tmp/manager.tar.gz https://www.flamenco.io/download/flamenco-manager-2.7-linux.tar.gz
RUN tar -xzf /tmp/manager.tar.gz -C /tmp/manager
RUN mkdir -p /manager
RUN mv /tmp/manager/flamenco-manager-2.7/* /manager


ADD params.py /manager/params.py
ADD ./flamenco-manager.yaml /manager/flamenco-manager.empty.yaml

RUN mkdir -p /var/logs/flamenco
ADD run-manager.sh /manager/run.sh
RUN chmod +x /manager/run.sh
ENTRYPOINT /manager/run.sh
