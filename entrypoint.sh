#!/bin/sh
cp /usr/share/zoneinfo/$TZ /etc/localtie
echo $TZ > /etc/timezone

rtl_433 -d $DEVICEINDEX -M newmodel -F mqtt://$MQTT_IP:$MQTT_PORT,retain=0,devices=sensors/rtl_433/[model:""]/[id:0] -C $UNITS
