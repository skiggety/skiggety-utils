FROM ubuntu

RUN touch /.in_docker
RUN apt update
RUN apt install -y git
RUN apt install -y sudo
RUN apt install -y curl
RUN apt install -y libz-dev
RUN apt install -y libssl-dev

# TODO: ideally skiggety utils should handle this:
RUN apt install -y vim

RUN mkdir -p /code/skiggety-utils
WORKDIR /code/skiggety-utils

ENV SKIGGETY_UTILS_DIR="/code/skiggety-utils"
ENV PATH="${PATH}:./PWD_BIN:$SKIGGETY_UTILS_DIR/bin"

# optimizations, stuff to do before runnining installers/basic_prerequisites:
RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN apt install -y bundler
ADD ./bin/skiggety_env_exec ./bin/skiggety_env_exec
ADD ./lib/include_in_bashrc.bash ./lib/include_in_bashrc.bash
ADD ./lib/skiggety-utils.bash ./lib/skiggety-utils.bash
RUN ./bin/skiggety_env_exec rbenv install 2.7.6
RUN ./bin/skiggety_env_exec rbenv install 3.1.3
RUN gem install bundler

ADD . .

RUN rm installers/.*updated_with_version* installers/.*installed_with_version* installers/.*configured_with_version*

# TODO: DELETE the " || true" when you don't need it for debugging. It allows us to get into the instance to pick up
# where this command left off::
RUN ./bin/skiggety_env_exec ./installers/basic_prerequisites --non-interactive || true

# TODO: set up something helpful to display on the screen when the user logs in with bash

CMD sleep infinity
