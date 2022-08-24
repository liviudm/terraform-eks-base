FROM ubuntu:latest

ARG RUNNER_VERSION="2.295.0"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip \
        awscli git nodejs && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m docker

RUN cd /home/docker && \
    mkdir actions-runner && \
    cd actions-runner && \
    curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    chown -R docker ~docker && \
    /home/docker/actions-runner/bin/installdependencies.sh

COPY start.sh start.sh

RUN chmod +x start.sh

USER docker

