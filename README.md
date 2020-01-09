# docker-rtl433
merbanan/rtl_433 in docker!

This justs builds rtl_433 in alpine for use in other containers so I don't have to constantly reduplicate my work.

You can find the full source and documentation at https://github.com/merbanan/rtl_433.

Example dockerfile based upon this:

```
FROM va7eex/rtl433:latest

ENV DATATYPE="csv"
ENV LOGNAME="environment.csv"

ENTRYPOINT rtl_433 -F $DATATYPE:/tmp/$LOGNAME -T 60 && cat /tmp/$LOGNAME
```
