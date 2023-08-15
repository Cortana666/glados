#!/bin/bash
# author:yangjian
# 2021-07-06
# glados sign up

getSignTime(){
    # 获取随机合法小时
    sign_hour=`expr $RANDOM % 24`
    if [ $sign_hour -lt 10 ]
    then
        sign_hour="0$sign_hour"
    fi

    # 获取随机合法分钟
    sign_minute=`expr $RANDOM % 60`
    if [ $sign_minute -lt 10 ]
    then
        sign_minute="0$sign_minute"
    fi

    # 获取随机合法秒
    sign_second=`expr $RANDOM % 60`
    if [ $sign_second -lt 10 ]
    then
        sign_second="0$sign_second"
    fi

    # 组成签到时间并输出
    sign_time="$sign_hour:$sign_minute:$sign_second"
    echo "明天签到时间为$sign_time"
}

sign(){
    # 请求签到接口并记录请求日志
    response=$(curl -b "$1" -d "token=glados.one" https://glados.rocks/api/user/checkin)
    echo $response >> api.log 2>&1

    # 匹配签到结果
    message=$(echo $response | grep -Eo "message\":\"([a-zA-Z0-9 !]*)")
    message=${message: 10}
    case "$message" in
        "Please Try Tomorrow") message="签到失败，请明天再试"
        ;;
        "Checkin! Get 1 Day") message="签到成功，有效期延长1天"
        ;;
        "Checkin! Get 0 day") message="签到成功，有效期没有延长"
        ;;
    esac

    # 输出签到结果并记录签到日志
    message=$(date "+%Y-%m-%d %H:%M:%S")$message
    echo $message >> sign.log 2>&1
    echo $message
}

main(){
    # 今日即时签到
    sign "$1"

    is_need_time=1
    is_need_sign=0

    while true
    do
        # 判断是否需要设置明天签到时间
        if [ $is_need_time == 1 ]
        then
            getSignTime
            is_need_time=0
        fi

        # 判断跳日
        if [ $(date "+%H") == "00" ]
        then
            is_need_sign=1
        fi

        now_time=$(date "+%H:%M:%S")

        # 到达时间且今日脚本未签到则签到
        if [ $sign_time == $now_time -a $is_need_sign == 1 ]
        then
            is_need_time=1
            is_need_sign=0
            sign "$1"
        fi

        # 脚本循环睡眠时间
        sleep 0.3
    done
}

# 主程序循环每天随机时间签到（只需执行一次）
main "COOKIE"

# 手动执行脚本签到（每天需执行一次）
# sign "COOKIE"
