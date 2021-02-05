#syntax = docker/dockerfile:experimental

FROM ruby:2.7.2-slim AS nodejs

RUN apt update && apt install -y --no-install-recommends curl
WORKDIR /tmp

ARG NODE_VERSION=v12.18.1
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
ENV NVM_DIR /root/.nvm
RUN . $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use $NODE_VERSION
RUN mv $NVM_DIR/versions/node/$NODE_VERSION node


FROM ruby:2.7.2-slim

WORKDIR /app

RUN apt update && apt install -y --no-install-recommends \
    build-essential default-mysql-client default-libmysqlclient-dev

RUN gem update bundler

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install --jobs=4

COPY . .

COPY --from=nodejs /tmp/node /opt/node
ENV NODE_PATH /opt/node/lib/node_modules
ENV PATH      /opt/node/bin:$PATH

EXPOSE 3000