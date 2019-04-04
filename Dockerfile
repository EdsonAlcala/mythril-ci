FROM python:3.7.2-alpine3.9

RUN apk add --update --no-cache build-base git openssl-dev libffi-dev make gcc g++ musl-dev && \
    pip3 install --upgrade pip setuptools


RUN apk --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --update --no-cache add leveldb leveldb-dev && \
    pip3 install mythril

# RUN apk add --update --no-cache ca-certificates wget && \
#     wget https://github.com/ethereum/solidity/releases/download/v0.5.4/solc-static-linux && \
#     chmod +x solc-static-linux && \
#     mv ./solc-static-linux /usr/local/bin/solc

RUN apk add --update --no-cache ca-certificates wget bash && \
    wget https://github.com/ethereum/solidity/releases/download/v0.4.24/solc-static-linux && \
    chmod +x solc-static-linux && \
    mv ./solc-static-linux /usr/local/bin/solc

WORKDIR /opt

COPY ./scripts/scanner .

RUN mv scanner /usr/bin/scanner && \
    chmod +x /usr/bin/scanner

CMD ["sh"]