FROM python:3.10-slim-bullseye as builder

COPY requirements.txt /tmp/requirements.txt

RUN apt-get update -y \
	&& apt-get upgrade -y \
	&& apt-get install -y git libopencv-dev openssl libpq-dev gcc\
	&& apt-get autoremove -y \
	&& apt-get clean \
	&& rm -rf /usr/local/src/* \
	&& pip install --upgrade pip \
	&& pip install --no-cache-dir -r /tmp/requirements.txt \
	&& rm -rf /tmp/requirements.txt

FROM python:3.10-slim-bullseye

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages

ENV PYTHONPATH "${PYTHONPATH}:/workspace"