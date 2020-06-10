# docker-rtl433
merbanan/rtl_433 in docker!

# General Description

This image provides both an MQTT publishing image (`:latest`/`:mqtt`) and a base image that simply compiles rtl_433 for further use (`:base`)

You can find the full source and documentation at https://github.com/merbanan/rtl_433.

For this to work at all the hardware host that you are running docker on **requires** one or more RTLSDR USB dongles plugged in.

# Base Image:

Available by executing the command `docker pull va7eex/rtl433:base`

This justs builds rtl_433 in alpine for use in other containers so I don't have to constantly reduplicate my work.

Example dockerfile based upon this:

```
FROM va7eex/rtl433:base

ENV DATATYPE="csv"
ENV LOGNAME="environment.csv"

ENTRYPOINT rtl_433 -F $DATATYPE:/tmp/$LOGNAME -T 60 && cat /tmp/$LOGNAME
```

# MQTT publisher

Available by executing the command `docker pull va7eex/rtl433:latest`

This image will connect to an MQTT broker and publish all data it can receive and process to various topics under `senors/rtl_433/$deviceType/$deviceID/#`.

An example docker-compose file:

```
version: "3"
networks:
  internaldockernetwork:
services:
  mqtt-broker:
    image: eclipse-mosquitto:latest
    container_name: mqtt-broker
    restart: always
    networks:
      - internaldockernetwork
  rtl433:
    image: va7eex/rtl433:mqtt
    container_name: rtl433-mqtt
    environment:
      - MQTT_IP=mqtt-broker
      - UNITS=si
      - TZ=Etc/UTC
      #note this is only necessary if you have multiple SDRs plugged in.
      - DEVICEINDEX=0
    restart: always
    networks:
      - internaldockernetwork
    depends_on:
      - mqtt-broker
    #while both of these are not necessarily needed, at least one is.
    privileged: true
    devices:
      - "/dev/bus/001/004:/dev/bus/001/004"
```

For further reading regarding devices in docker-compose consult [docker-compose reference](https://docs.docker.com/compose/compose-file/#devices) and [docker run reference](https://docs.docker.com/engine/reference/commandline/run/#add-host-device-to-container---device).

An advanced usage of this image can be found at https://hub.docker.com/r/va7eex/wunderground-updater
