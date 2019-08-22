FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      cmake \
      curl \
      g++ \
      libpulse-dev \
      make \
      npm \
      qt5-default \
      qt5-qmake \
      qtbase5-dev \
      qtdeclarative5-dev \
      qtmultimedia5-dev \
      qtscript5-dev \
      qttools5-dev \
      qttools5-dev-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG VERSION='7.1.1'

# See https://github.com/Bionus/imgbrd-grabber/wiki/Compilation#linux
RUN curl \
      --location \
      --output '/tmp/grabber.tar.gz' \
      "https://github.com/Bionus/imgbrd-grabber/archive/v${VERSION}.tar.gz" && \
    tar xf '/tmp/grabber.tar.gz' -C / && \
    mv "/imgbrd-grabber-${VERSION}" '/imgbrd-grabber' && \
    cd '/imgbrd-grabber' && \
    mkdir -p 'build' && \
    cd 'build' && \
    cmake .. && \
    cmake --build . -- -j `nproc` && \
    cd .. && \
    mv build/gui/Grabber* 'release/' && \
    touch 'release/settings.ini' && \
    rm -r '/tmp'

CMD ['/imgbrd-grabber/release/Grabber']
