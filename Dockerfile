FROM ubuntu:xenial
SHELL ["/bin/bash", "-c"]
RUN apt-get update && \
    apt-get install -y \
    python-virtualenv \
    curl python-dev \
    python-pip \
    build-essential \
    automake \
    pkg-config \
    libtool
RUN useradd --home-dir /home/chaum --create-home --shell /bin/bash --skel /etc/skel/ chaum
USER chaum
COPY bitcoin-0.14.2-x86_64-linux-gnu.tar.gz /home/chaum
WORKDIR /home/chaum
RUN tar xaf bitcoin-0.14.2-x86_64-linux-gnu.tar.gz
ENV PATH "/home/chaum/bitcoin-0.14.2/bin:${PATH}"
RUN which bitcoind || false
RUN curl -L -O https://github.com/fivepiece/joinmarket-clientserver/archive/test_travis.tar.gz
RUN tar xaf test_travis.tar.gz
WORKDIR "joinmarket-clientserver-test_travis"
RUN ./install.sh
RUN source jmvenv/bin/activate && ./test/run_tests.sh
