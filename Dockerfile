FROM ubuntu

RUN touch /.in_docker
RUN apt update
RUN apt install -y git
RUN apt install -y sudo
RUN apt install -y wget curl
RUN apt install -y make build-essential
RUN apt install -y libz-dev libssl-dev zlib1g-dev libbz2-dev libyaml-dev
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="Etc/UTC"
RUN apt install -y libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev

# TODO: ideally skiggety utils should handle this:
RUN apt install -y vim

RUN mkdir -p /code/skiggety-utils
WORKDIR /code/skiggety-utils

ENV SKIGGETY_UTILS_DIR="/code/skiggety-utils"
ENV PATH="${PATH}:./PWD_BIN:$SKIGGETY_UTILS_DIR/bin"

# optimizations, stuff to do before runnining installers/basic_prerequisites:
RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN git clone https://github.com/pyenv/pyenv.git /root/.pyenv
RUN apt install -y bundler
ADD ./bin/skiggety_env_exec ./bin/skiggety_env_exec
ADD ./lib/include_in_bashrc.bash ./lib/include_in_bashrc.bash
ADD ./lib/skiggety-utils.bash ./lib/skiggety-utils.bash
RUN ./bin/skiggety_env_exec rbenv install 2.7.6
RUN ./bin/skiggety_env_exec rbenv install 3.2.0
RUN ./bin/skiggety_env_exec pyenv install 3.11.1
RUN gem install bundler
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
ADD ./PWD_BIN/ruby_setup ./PWD_BIN/ruby_setup
RUN ./bin/skiggety_env_exec ./PWD_BIN/ruby_setup

ADD . .

RUN rm installers/.*updated_with_version* installers/.*installed_with_version* installers/.*configured_with_version*

# TODO: DELETE the " || true" when you don't need it for debugging. It allows us to get into the instance to pick up
# where this command left off::
RUN ./bin/skiggety_env_exec ./installers/basic_prerequisites --non-interactive || true

# TODO: set up something helpful to display on the screen when the user logs in with bash

CMD sleep infinity
