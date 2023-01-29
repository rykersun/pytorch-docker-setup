FROM pytorch/pytorch:latest
MAINTAINER rykersun

RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip
RUN pip3 install \
    cython \
    && rm -rf ~/.cache/pip

ADD simultaneous_semantic_and_instance_segmentation/ /workspace/simultaneous_semantic_and_instance_segmentation/
RUN cd /workspace/simultaneous_semantic_and_instance_segmentation/detectron2/ && python setup.py install
