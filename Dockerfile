FROM alpine

RUN apk add --no-cache --update git libusb-dev libtool build-base cmake
RUN apk add --no-cache --repository https://dl-3.alpinelinux.org/alpine/edge/testing librtlsdr-dev

WORKDIR /usr/src/
RUN git clone --recursive https://github.com/merbanan/rtl_433
RUN mkdir /usr/src/rtl_433/build
WORKDIR /usr/src/rtl_433/build
RUN cmake .. -DENABLE_SOAPYSDR=OFF
RUN make && make install
