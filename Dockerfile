FROM python:3.7-slim-buster


# openjdk-11-jre-headless

RUN set -x && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y --no-install-recommends install \
        vim cron procps gnupg2 \
        procps ca-certificates net-tools && \
    apt-get clean -y && \
    rm -rf \
        /var/cache/debconf/* \
        /var/lib/apt/lists/* \
        /var/log/* \
        /tmp/* \
        /var/tmp/*

ENV DAGSTER_HOME /var/lib/data/dagster_home
RUN mkdir -p '/var/lib/data/dagster_home'

WORKDIR /app

COPY ./entrypoint.sh /
COPY ./app /app
COPY ./dagster.yaml /var/lib/data/dagster_home/
# COPY ./deploy /deploy

VOLUME [ "/app" ]

COPY requirements.txt requirements.txt
RUN set -x && ( echo; echo "awscli" ) >> requirements.txt && pip install -r requirements.txt

EXPOSE 3000
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
