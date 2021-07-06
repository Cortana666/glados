#!/bin/bash
# author:yangjian
# 2021-07-06
# glados sign up

getSignTime(){
    sign_hour=`expr $RANDOM % 24`
    if [ $sign_hour -lt 10 ]
    then
        sign_hour="0$sign_hour"
    fi

    sign_minute=`expr $RANDOM % 60`
    if [ $sign_minute -lt 10 ]
    then
        sign_minute="0$sign_minute"
    fi

    sign_second=`expr $RANDOM % 60`
    if [ $sign_second -lt 10 ]
    then
        sign_second="0$sign_second"
    fi

    sign_time="$sign_hour:$sign_minute:$sign_second"
    echo "下次签到时间为明天$sign_time"
}

sign(){
    curl -b "$1" -d "token=glados_network" https://glados.rocks/api/user/checkin >> api.log 2>&1
    echo "签到成功"
}

main(){
    is_reset_time=1
    is_sign=0

    while true
    do
        if [ $is_reset_time == 1 ]
        then
            getSignTime
            is_reset_time=0
        fi

        if [ $(date "+%H") == "00" ]
        then
            is_sign=1
        fi

        now_time=$(date "+%H:%M:%S")

        if [ $sign_time == $now_time -a $is_sign == 1 ]
        then
            is_reset_time=1
            is_sign=0
            sign "_ga=GA1.2.940791902.1623222125; koa:sess=eyJjb2RlIjoiR1NBQUQtV0E0R0wtNEswVzItSkdRUDEiLCJ1c2VySWQiOjg2MzE5LCJfZXhwaXJlIjoxNjQ5MjA3NzkxMDEzLCJfbWF4QWdlIjoyNTkyMDAwMDAwMH0=; koa:sess.sig=2zVHsQ16UsSqQGTh8i4xeTyPNxw; _gid=GA1.2.933171949.1623724563; _gat_gtag_UA_104464600_2=1"
        fi

        sleep 0.3
    done
}

main