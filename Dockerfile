FROM python:3.7.2-alpine3.9

# RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main" > /etc/apk/repositories
# RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories

RUN apk add --no-cache --update-cache gfortran build-base freetype-dev libpng-dev openblas-dev libffi-dev openssl-dev
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h
RUN pip install -U matplotlib
RUN pip install -U pip setuptools wheel
# RUN apk add --update --no-cache build-base git openssl-dev libffi-dev freetype-dev make gcc g++ musl-dev && \
#     pip install -U pip setuptools wheel

RUN apk --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --update --no-cache add leveldb leveldb-dev && \
    pip install -U mythril

# TODO: Make solidity version a parameter
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

CMD ["myth"]