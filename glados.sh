#!/bin/bash
# author:yangjian
# 2021-06-18
# glados sign up

hour=9
while true
do
    now=$(date "+%H")
    if [ $now == $hour ]
    then
        curl -b 'COOKEI' -d 'token=glados_network' https://glados.rocks/api/user/checkin
        hour=`expr $hour - 1`
    fi
    sleep 3600
done