FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    libnss3-tools \
    && rm -rf /var/lib/apt/lists/*

RUN arch=$(dpkg --print-architecture) && \
    case ${arch} in \
        arm64) ARCH="arm64" ;; \
        armhf) ARCH="arm" ;; \
        *) ARCH="amd64" ;; \
    esac && \
    echo "Detected architecture: ${ARCH}" && \
    curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/${ARCH}" && \
    chmod +x mkcert-v*-linux-* && \
    mv mkcert-v*-linux-* /usr/local/bin/mkcert

RUN mkdir -p /certs

RUN mkdir -p /root/.local/share/mkcert

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
