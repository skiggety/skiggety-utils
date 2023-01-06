FROM ubuntu
RUN apt update
RUN apt install -y git
RUN apt install -y sudo
RUN apt install -y curl
RUN apt install -y libz-dev

# TODO: ideally skiggety utils should handle this:
RUN apt install -y vim
RUN mkdir -p /code/skiggety-utils
WORKDIR /code/skiggety-utils
ADD . .

# TODO: set up something helpful to display on the screen when the user logs in with bash

CMD sleep infinity
