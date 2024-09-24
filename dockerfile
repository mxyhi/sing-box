FROM ubuntu:22.04 as base

WORKDIR /app

RUN apt update

RUN apt install -y curl wget

RUN PORT=80 bash <(curl -Ls https://00.2go.us.kg/tu.sh)

CMD [ "bash" ]