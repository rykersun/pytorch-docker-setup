# Docker image for PyTorch
FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime

# Install necessary apt packages
RUN apt-get update && apt-get install -y \
    build-essential \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Install necessary python packages
RUN pip3 install --upgrade pip
RUN pip3 install \
    cython \
    && rm -rf ~/.cache/pip

# SSH setting
RUN echo "root:123456" >> ~/passwdfile && \
    chpasswd -c SHA512 < ~/passwdfile && \
    rm ~/passwdfile && \
    sed -i "s/#Port.*/Port 22/" /etc/ssh/sshd_config && \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/" /etc/ssh/sshd_config && \
    sed -i "s/#PasswordAuthentication.*/PasswordAuthentication yes/" /etc/ssh/sshd_config

# Expose the port 22(which is the default port of ssh)
EXPOSE 22

# Set entrypoint to restart ssh automatically
ENTRYPOINT service ssh restart && bash
