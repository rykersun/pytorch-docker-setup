FROM pytorch/pytorch:latest
MAINTAINER rykersun

RUN apt-get update && apt-get install -y \
    build-essential \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip
RUN pip3 install \
    cython \
    && rm -rf ~/.cache/pip

ADD simultaneous_semantic_and_instance_segmentation/ /workspace/simultaneous_semantic_and_instance_segmentation/
RUN cd /workspace/simultaneous_semantic_and_instance_segmentation/detectron2/ && python setup.py install

RUN ln -s /workspace/simultaneous_semantic_and_instance_segmentation/ /root/simultaneous_semantic_and_instance_segmentation

# ssh setting
RUN echo "root:123456" >> ~/passwdfile && \
    chpasswd -c SHA512 < ~/passwdfile && \
    rm ~/passwdfile && \
    sed -i "s/#Port.*/Port 22/" /etc/ssh/sshd_config && \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/" /etc/ssh/sshd_config && \
    sed -i "s/#PasswordAuthentication.*/PasswordAuthentication yes/" /etc/ssh/sshd_config

# expose the port 22(which is the default port of ssh)
EXPOSE 22

# set entrypoint to restart ssh automatically
ENTRYPOINT service ssh restart && bash
