FROM ubuntu:20.04

ENV CONTAINER_USER=user
ENV VERSION_URL https://upwork-usw2-desktopapp.upwork.com/binaries/v5_6_6_12_04a4b2fe30dc4606/upwork_5.6.6.12_amd64.deb

ADD $VERSION_URL /opt/upwork_amd64.deb
RUN apt-get update \
  && apt-get install -y sudo libx11-xcb1 \
  && dpkg -i /opt/upwork_amd64.deb || true \
  && apt-get install -f -y \
  && rm -rf /var/lib/apt/lists/*

COPY data/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
