FROM ubuntu:18.04

# https://github.com/ComunidadAylas/PackSquash/wiki/Installation-guide#linux
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    curl \
    wget \
    libgstreamer1.0-0 \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://api.github.com/repos/ComunidadAylas/PackSquash/releases/latest \
    | grep "browser_download_url.*PackSquash.executable.Linux.zip\"" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget -qi -\
    && unzip PackSquash.executable.Linux.zip \
    && chmod a+x packsquash \
    && mv packsquash /usr/local/bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
