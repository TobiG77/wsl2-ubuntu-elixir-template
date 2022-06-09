FROM registry.access.redhat.com/ubi8/ubi

ARG RHSM_TOKEN
ENV YUM_DEFAULT_ARGS " --disableplugin=subscription-manager "

ENV BASE_TOOLS="bind-utils \
    ca-certificates \
    curl \
    fontconfig \
    gzip \
    glibc-langpack-en \
    git-core \
    htop \
    inotify-tools \
    iputils \
    less \
    openssl \
    procps \
    tar \
    unzip "

ENV DEV_PACKAGES="openssl-devel"

RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    dnf -y update
RUN dnf -y install ${BASE_TOOLS} ${DEV_PACKAGES}

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN mkdir -p /app/source
WORKDIR /app/source

CMD ["/usr/bin/echo", "Please set your own CMD"]
