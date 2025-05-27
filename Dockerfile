ARG POSTGRES_VERSION=17
ARG POSTGIS_VERSION=3.5

FROM postgis/postgis:${POSTGRES_VERSION}-${POSTGIS_VERSION}

ARG POSTGRES_VERSION
ARG POSTGIS_VERSION
ARG PGVECTOR_VERSION=0.8.0

# Install pgvector
RUN apt update && \
    apt install -y --no-install-recommends \
        build-essential \
        postgresql-server-dev-${POSTGRES_VERSION} \
        git

RUN cd /tmp && \
    git clone --branch v${PGVECTOR_VERSION} https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make && \
    make install 

RUN rm -rf /tmp/pgvector && \
    apt purge -y --auto-remove \
        build-essential \
        postgresql-server-dev-${POSTGRES_VERSION} \
        git 

ADD overlay/ /