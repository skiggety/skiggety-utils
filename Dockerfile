FROM ubuntu

RUN touch /.in_docker_demo
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

# and how about nano too, just for the docker demo, since some people might rely on it
RUN apt install -y nano

ENV SKIGGETY_UTILS_DIR="/root/code/skiggety-utils"
RUN mkdir -p "$SKIGGETY_UTILS_DIR"
WORKDIR "$SKIGGETY_UTILS_DIR"

ENV PATH="${PATH}:./PWD_BIN:$SKIGGETY_UTILS_DIR/bin"

# optimizations, stuff to do before runnining installers/basic_prerequisites so it doesn't have to work as hard:
RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN git clone https://github.com/pyenv/pyenv.git /root/.pyenv
RUN apt install -y bundler
ADD ./bin/skiggety_env_exec ./bin/skiggety_env_exec
ADD ./lib/include_in_bashrc.bash ./lib/include_in_bashrc.bash
ADD ./lib/skiggety-utils.bash ./lib/skiggety-utils.bash
RUN echo "The next step might take a while the first time...."
RUN ./bin/skiggety_env_exec rbenv install 2.7.6
RUN echo "The next step might take a while the first time...."
# RUN ./bin/skiggety_env_exec rbenv install 3.1.3
RUN ./bin/skiggety_env_exec pyenv install 3.11.1
RUN gem install bundler
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
ADD ./PWD_BIN/ruby_setup ./PWD_BIN/ruby_setup
RUN ./bin/skiggety_env_exec ./PWD_BIN/ruby_setup
RUN apt install -y wamerican-large
ENV PYENV_VERSION=3.11.1
RUN ./bin/skiggety_env_exec python -m pip install --upgrade pip
RUN ./bin/skiggety_env_exec pip install nose2
RUN ./bin/skiggety_env_exec python -m pip install pylint

ADD . .

RUN rm installers/.markers/*_with_version*

# TODO: set up something helpful to display on the screen when the user logs in with bash

CMD sleep infinity
