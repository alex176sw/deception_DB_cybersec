
FROM postgres:16.1

ENV WORKDIR=/home/postgres
WORKDIR $WORKDIR

RUN localedef -i it_IT -c -f UTF-8 -A /usr/share/locale/locale.alias it_IT.UTF-8
ENV LANG it_IT.utf8

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get upgrade -y && apt-get clean all
    #apt-get install -y wget unzip git python3 python3-pip python3.11-venv && \

#COPY ./image_configuration/scripts/*.py ${WORKDIR}/scripts/
COPY ./image_configuration/postgres_initialization /docker-entrypoint-initdb.d
RUN chown -R postgres:postgres ${WORKDIR}

