FROM ubuntu

RUN touch /.in_docker_demo
RUN apt update
RUN apt install -y git
RUN apt install -y sudo
RUN apt install -y wget curl
RUN apt install -y make build-essential
RUN apt install -y libz-dev libssl-dev zlib1g-dev libbz2-dev libyaml-dev
RUN apt install -y wamerican-large
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
# TODO^294 IN_PROGRESS NOW: upgrade?:
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2
RUN apt install -y bundler
ADD ./bin/skiggety_env_exec ./bin/skiggety_env_exec
ADD ./lib/include_in_bashrc.bash ./lib/include_in_bashrc.bash
ADD ./lib/skiggety-utils.bash ./lib/skiggety-utils.bash
ADD .tool-versions .tool-versions
RUN ./bin/skiggety_env_exec asdf plugin-add direnv
RUN ./bin/skiggety_env_exec asdf plugin-add ruby
RUN echo "The next step might take a while the first time...."
RUN ./bin/skiggety_env_exec asdf install ruby 3.3.4
RUN ./bin/skiggety_env_exec asdf plugin-add python
RUN echo "The next step might take a while the first time...."
RUN ./bin/skiggety_env_exec asdf install python 3.11.1

RUN gem install bundler
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
ADD ./PWD_BIN/ruby_setup ./PWD_BIN/ruby_setup
RUN ./bin/skiggety_env_exec ./PWD_BIN/ruby_setup
RUN ./bin/skiggety_env_exec python -m pip install --upgrade pip
RUN ./bin/skiggety_env_exec pip install nose2
RUN ./bin/skiggety_env_exec python -m pip install pylint

ADD . .

RUN rm -f installers/.markers/*_with_version*

# If I'm brave enough to make sure it doesn't loop forever.  It better run only on login shells:
# TODO: RUN echo "install-skiggety-utils;less README.md;dev" >> /root/.bashrc

# TODO: set up something helpful to display on the screen when the user logs in with bash

CMD sleep infinity
