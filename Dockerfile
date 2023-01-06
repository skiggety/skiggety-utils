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
ADD . .
RUN rm installers/.*updated_with_version* installers/.*installed_with_version* installers/.*configured_with_version*

ENV SKIGGETY_UTILS_DIR="/code/skiggety-utils"
ENV PATH="${PATH}:./PWD_BIN:$SKIGGETY_UTILS_DIR/bin"

# TODO: DELETE the " || true" when you don't need it for debugging:
RUN ./bin/skiggety_env_exec ./installers/basic_prerequisites --non-interactive || true

# TODO: set up something helpful to display on the screen when the user logs in with bash

CMD sleep infinity
