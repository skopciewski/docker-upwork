FROM ubuntu:artful

ENV CONTAINER_USER=user
ENV VERSION_URL https://updates-desktopapp.upwork.com/binaries/v5_0_1_442_9advaddbconscszu/upwork_5.0.1.442_amd64.deb

RUN apt-get update && apt-get install -y \
    gconf-service \
    gksu \
    libasound2 \
    libatk1.0-0 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libfreetype6 \
    libgconf-2-4 \
    libgtkglext1 \
    libharfbuzz-gobject0 \
    libnspr4 \
    libnss3 \
    libpango1.0-0 \
    libxss1 \
    libxtst6 \
    systemd- \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

ADD $VERSION_URL /opt/upwork_amd64.deb
RUN dpkg -i /opt/upwork_amd64.deb 

COPY data/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
