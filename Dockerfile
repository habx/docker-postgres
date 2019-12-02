FROM postgres:12 AS build

ENV WAL2JSON_COMMIT_SHA=da90c76a69966a7dfcf0657acacde916164bd9c0

# Install the packages which will be required to get everything to compile
RUN apt-get update && \
    apt-get install -f -y --no-install-recommends \
        software-properties-common \
        build-essential \
        pkg-config \
        git \
        postgresql-server-dev-$PG_MAJOR

RUN git clone https://github.com/eulerto/wal2json -b master --single-branch && \
    cd /wal2json && \
    git checkout $WAL2JSON_COMMIT_SHA && \
    make && make install

FROM postgres:12

COPY --from=build /usr/lib/postgresql/$PG_MAJOR/lib/wal2json.so /usr/lib/postgresql/$PG_MAJOR/lib/
COPY postgresql.conf.sample /usr/share/postgresql/postgresql.conf.sample