# docker-rtl433
merbanan/rtl_433 in docker!

This justs builds rtl_433 in alpine for use in other containers so I don't have to constantly reduplicate my work.

You can find the full source and documentation at https://github.com/merbanan/rtl_433.

For this to work at all the hardware host that you are running docker on **requires** an RTLSDR USB dongle plugged in.

Example dockerfile based upon this:

```
FROM va7eex/rtl433:latest

ENV DATATYPE="csv"
ENV LOGNAME="environment.csv"

ENTRYPOINT rtl_433 -F $DATATYPE:/tmp/$LOGNAME -T 60 && cat /tmp/$LOGNAME
```

Alternatively specify a MQTT broker, this is also accessible pre-built via the `va7eex/rtl433:latest-mqtt` tag

```
FROM va7eex/rtl433:latest

ENV MQTT_IP=mqtt-broker
ENV MQTT_PORT=1883
#can be 'si', 'customary', or 'native'
ENV UNITS=si
ENV TZ=Etc/UTC

ENTRYPOINT cp /usr/share/zoneinfo/$TZ /etc/localtime \
	echo $TZ > /etc/timezone \
	rtl_433 -M newmodel -F mqtt://$MQTT_IP:$MQTT_PORT,retain=0,devices=sensors/rtl_433/[model:""]/[id:0] -C $UNITS
```
