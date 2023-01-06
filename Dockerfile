FROM ubuntu
RUN apt update
RUN apt install -y git
RUN mkdir -p /code/skiggety-utils
RUN git clone https://github.com/skiggety/skiggety-utils.git /code/skiggety-utils
WORKDIR /code/skiggety-utils

# TODO: set up something helpful to display on the screen when the user logs in with bash

CMD sleep infinity
