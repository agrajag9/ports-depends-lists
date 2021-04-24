#!/bin/sh

for LIST in build package run test; do \
    echo "port,${LIST}" >/tmp/${LIST}-depends-list.csv
done

find /usr/ports -mindepth 2 -maxdepth 2 -type d -print0 \
    | parallel -0 -n1 'cd {}; for LIST in build package run test; do echo -n "{}:make ${LIST}-depends-list..."; make ${LIST}-depends-list | while read LINE; do echo $( echo {} | cut -d"/" -f4,5 ),$( echo ${LINE} | cut -d"/" -f4,5 ) >>/tmp/${LIST}-depends-list.csv; done; echo " done!"; done'
