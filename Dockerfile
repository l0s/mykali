# syntax=docker/dockerfile:1.2

FROM kalilinux/kali-rolling:latest

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get -y update \
  && apt-get install -y --no-install-recommends \
    kali-linux-headless \
    #kali-tools-crypto-stego \
    #kali-tools-fuzzing \
    #kali-tools-windows-resources \
    #kali-tools-information-gathering \
    kali-tools-vulnerability \
    kali-tools-web \
    kali-tools-database \
    kali-tools-passwords \
    #kali-tools-reverse-engineering \
    kali-tools-exploitation \
    kali-tools-sniffing-spoofing 
    #kali-tools-post-exploitation \
    #kali-tools-forensics \
    #kali-tools-reporting

RUN apt-get -y update \
  && apt-get install -y --no-install-recommends \
    iputils-ping \
    less \
    python3-pip

# Install Impacket
RUN mkdir -p /var/tmp/install
WORKDIR /var/tmp/install
RUN git clone --depth 1 --branch impacket_0_9_23 https://github.com/SecureAuthCorp/impacket.git
WORKDIR /var/tmp/install/impacket
RUN python3 -m pip install .

RUN --mount=type=secret,id=password cat /run/secrets/password \
  | xargs openssl passwd -1 \
  | xargs useradd --system \
    --gid root \
    --groups sudo \
    --create-home \
    --shell /usr/bin/zsh kali \
    --password
USER kali
WORKDIR /var/workspace
