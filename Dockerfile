FROM debian:buster-slim
MAINTAINER Defendi

SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN apt update && apt upgrade -y

RUN apt-get install -y --no-install-recommends \
            python3-pip \
            python3-dev

COPY ./requirements.txt /opt/sources/
COPY ./db.sqlite3 /opt/sources/

COPY ./LICENSE /opt/sources/
COPY ./teste.py /opt/sources/
COPY ./manage.py /opt/sources/
COPY ./README.md /opt/sources/

WORKDIR /opt/sources/

RUN mkdir -p DjEnquete
RUN mkdir -p polls

ADD ./DjEnquete /opt/sources/DjEnquete/
ADD ./polls /opt/sources/polls


RUN pip3 install --no-cache-dir -r requirements.txt

USER root

EXPOSE 8000

ENTRYPOINT ["python3","manage.py","runserver"]
