FROM ubuntu

RUN apt update
RUN apt install -y git
RUN apt install -y sudo
RUN apt install -y wget curl
RUN apt install -y libz-dev libssl-dev zlib1g-dev libbz2-dev libyaml-dev
RUN apt install -y wamerican-large
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="Etc/UTC"
RUN apt install -y libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev

RUN apt install -y vim

# and how about nano too, just for the docker demo, since some people might rely on it
RUN apt install -y nano

RUN apt install -y fish

WORKDIR "/root/code/skiggety-utils"


ADD ./bin/skiggety_env_exec ./bin/skiggety_env_exec
ADD ./lib/include_in_bashrc.bash ./lib/include_in_bashrc.bash
ADD ./lib/skiggety-utils.bash ./lib/skiggety-utils.bash
ADD .tool-versions .tool-versions

ADD . .

RUN rm -f installers/.markers/*_with_version*

CMD sleep infinity
