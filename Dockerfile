FROM ubuntu:bionic

ARG VNC_PASSWORD

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    tigervnc-standalone-server \
    tigervnc-common \
    python-numpy \
    lxde \
    supervisor \
    firefox \
    nano && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/novnc/noVNC /noVNC && \
    git -C /noVNC checkout -b local 36bfcb0 && \
    echo "<meta http-equiv='refresh' content='0; url=vnc.html?autoconnect=1&resize=remote'>" > /noVNC/index.html && \
    git clone https://github.com/novnc/websockify /noVNC/utils/websockify && \
    git -C /noVNC/utils/websockify checkout -b local f0bdb0a && \
    rm -rf /noVNC/.git /noVNC/utils/websockify/.git

COPY supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ENV USER root

EXPOSE 6080

RUN mkdir /root/.vnc && \
    echo $VNC_PASSWORD | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd && \
    touch /root/.Xauthority && \
    update-alternatives --remove-all vncconfig

RUN mkdir /home/folder

CMD ["/usr/bin/supervisord","-n"]
