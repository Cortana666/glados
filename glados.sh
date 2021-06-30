#!/bin/bash
# author:yangjian
# 2021-06-18
# glados sign up

time=09
while true
do
    echo $(date "+%Y-%m-%d %H:%M:%S")
    now=$(date "+%H")
    if [ $now == $time ]
    then
        curl -b 'COOKIE' -d 'token=glados_network' https://glados.rocks/api/user/checkin
        time=`expr $time - 1`
        if [ $time == -1 ]
        then
        time=23
        fi
        if [ $time -lt 10 ]
        then
        time=0$time
        fi
    fi
    sleep 60
done