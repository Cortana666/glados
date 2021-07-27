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
    echo "下次签到时间为$(date "+%Y-%m-%d ")$sign_time"
}

sign(){
    response=$(curl -b "$1" -d "token=glados_network" https://glados.rocks/api/user/checkin)
    $response >> api.log 2>&1

    message=$(echo $response | grep -Eo "message\":\"([a-zA-Z0-9 !]*)")
    message=${message: 10}

    case "$message" in
        "Please Try Tomorrow") message="签到失败，请明天再试"
        ;;
        "Checkin! Get 1 day") message="签到成功，有效期延长1天"
        ;;
        "Checkin! Get 0 day") message="签到成功，有效期没有延长"
        ;;
    esac
    echo "$(date "+%Y-%m-%d %H:%M:%S")$message"
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
            sign "$1"
        fi

        sleep 0.3
    done
}

# 主程序循环每天随机时间签到（只需执行一次）
main "COOKIE"

# 手动执行脚本签到（每天需执行一次）
# sign "COOKIE"
