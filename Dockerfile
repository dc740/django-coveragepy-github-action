FROM python:3.8.1-slim

LABEL "com.github.actions.name"="Django Coverage Action for Python"
LABEL "com.github.actions.description"="Python Django Coverage GitHub Action"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="black"

RUN apt-get update \
&& apt-get install -y --no-install-recommends git gcc musl-dev libpq-dev linux-headers-generic \
&& apt-get purge -y --auto-remove \
&& rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip virtualenv

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
