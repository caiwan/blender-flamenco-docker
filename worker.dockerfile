# FROM nytimes/blender:latest
# FROM nytimes/blender:2.92-gpu-ubuntu18.04
FROM nytimes/blender:2.83-gpu-ubuntu18.04

USER root

RUN apt update -y \ 
&& apt install -y \
    curl \
    imagemagick \
    ffmpeg 

RUN mkdir -p /worker
RUN curl -o /tmp/worker.tar.gz https://www.flamenco.io/download/flamenco-worker-2.4-linux.tar.gz
RUN tar -xzf /tmp/worker.tar.gz -C /worker

ADD install.py /tmp/install.py
RUN blender -b -P /tmp/install.py

ADD run-worker.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT /run.sh
