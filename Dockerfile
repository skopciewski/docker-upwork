FROM ubuntu:rolling

ENV CONTAINER_USER=user
ENV VERSION_URL https://updates-desktopapp.upwork.com/binaries/v5_3_3_871_51d563431f844aff/upwork_5.3.3.871_amd64.deb

ADD $VERSION_URL /opt/upwork_amd64.deb
RUN apt-get update \
  && apt-get install -y sudo libx11-xcb1 \
  && dpkg -i /opt/upwork_amd64.deb || true \
  && apt-get install -f -y \
  && rm -rf /var/lib/apt/lists/*

COPY data/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
