FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y libssl-dev
RUN apt-get install -y --no-install-recommends build-essential python3.6 python3-pip python3-setuptools python3-dev
# https://linuxize.com/post/how-to-add-apt-repository-in-ubuntu/#installing-add-apt-repository-add-apt-repository-command-not-found-
RUN apt-get install -y software-properties-common
# https://www.digitalocean.com/community/tutorials/how-to-install-r-on-ubuntu-18-04-quickstart
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/'
RUN apt-get install -y r-base
RUN apt-cache policy r-base

RUN apt-get install -y build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev
RUN apt-get install -y libfontconfig1-dev
RUN apt-get install -y libgit2-dev libharfbuzz-dev libfribidi-dev
RUN apt-get install -y graphicsmagick-libmagick-dev-compat libgraphicsmagick++1-dev libmagick++-6-headers
RUN apt-get clean





# Install dependencies
COPY ./requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt

COPY ./packages.R /packages.R
RUN Rscript /packages.R 

# copy packages into docker
COPY ./dependent/ /dependent


# Setup directory structure
RUN mkdir /app
WORKDIR /app
COPY ./app/ /app

# COPY entrypoint.sh /entrypoint.sh
# RUN chmod 755 /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]
