FROM ubuntu:rolling

ENV CONTAINER_USER=user
ENV VERSION_URL https://updates-desktopapp.upwork.com/binaries/v5_4_2_3_6b1022fbf8794731/upwork_5.4.2.3_amd64.deb 

ADD $VERSION_URL /opt/upwork_amd64.deb
RUN apt-get update \
  && apt-get install -y sudo libx11-xcb1 \
  && dpkg -i /opt/upwork_amd64.deb || true \
  && apt-get install -f -y \
  && rm -rf /var/lib/apt/lists/*

COPY data/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
