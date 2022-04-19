FROM alpine:latest

RUN apk add --no-cache --update git libusb-dev libtool build-base cmake
RUN apk add --no-cache --repository https://dl-3.alpinelinux.org/alpine/edge/main librtlsdr-dev

COPY ./lib/rtl_433/ /usr/src/rtl_433/
RUN mkdir /usr/src/rtl_433/build

WORKDIR /usr/src/rtl_433/build
RUN cmake .. -DENABLE_SOAPYSDR=OFF &&\
	make &&\
	make install
