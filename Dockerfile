FROM python:3.8.1-slim

LABEL "com.github.actions.name"="Django Coverage Action for Python"
LABEL "com.github.actions.description"="Python Django Coverage GitHub Action"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="black"

# manual postgres fixes
RUN set -eux; \
	groupadd -r postgres --gid=999; \
# https://salsa.debian.org/postgresql/postgresql-common/blob/997d842ee744687d99a2b2d95c1083a2615c79e8/debian/postgresql-common.postinst#L32-35
	useradd -r -g postgres --uid=999 --home-dir=/var/lib/postgresql --shell=/bin/bash postgres; \
# also create the postgres user's home directory with appropriate permissions
# see https://github.com/docker-library/postgres/issues/274
	mkdir -p /var/lib/postgresql; \
	chown -R postgres:postgres /var/lib/postgresql
RUN mkdir -p /var/run/postgresql && chown -R postgres:postgres /var/run/postgresql && chmod 2777 /var/run/postgresql


RUN apt-get update \
&& apt-get install -y --no-install-recommends git gcc libc-dev python3-dev build-essential libpq-dev postgresql-11 postgresql-client-11 \
&& apt-get purge -y --auto-remove \
&& rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip virtualenv

# setup postgresql database and user.
# We don't expose the port, but allow all incomming connections
USER postgres
# configure the user for later. the service will be started in the entrypoint
RUN  service postgresql start \
&& psql -c "CREATE USER ctest WITH SUPERUSER PASSWORD 'coveragetest123';ALTER USER ctest CREATEDB;"
USER root


COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
