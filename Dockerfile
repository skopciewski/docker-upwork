FROM ubuntu:20.04

ENV CONTAINER_USER=user
ENV VERSION_URL https://upwork-usw2-desktopapp.upwork.com/binaries/v5_5_0_11_61df9c99b6df4e7b/upwork_5.5.0.11_amd64.deb

ADD $VERSION_URL /opt/upwork_amd64.deb
RUN apt-get update \
  && apt-get install -y sudo libx11-xcb1 \
  && dpkg -i /opt/upwork_amd64.deb || true \
  && apt-get install -f -y \
  && rm -rf /var/lib/apt/lists/*

COPY data/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
