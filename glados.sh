#!/bin/bash
# author:yangjian
# 2021-06-18
# glados sign up

curl -b '_ga=GA1.2.940791902.1623222125; koa:sess=eyJjb2RlIjoiR1NBQUQtV0E0R0wtNEswVzItSkdRUDEiLCJ1c2VySWQiOjg2MzE5LCJfZXhwaXJlIjoxNjQ5MjA3NzkxMDEzLCJfbWF4QWdlIjoyNTkyMDAwMDAwMH0=; koa:sess.sig=2zVHsQ16UsSqQGTh8i4xeTyPNxw; _gid=GA1.2.933171949.1623724563; _gat_gtag_UA_104464600_2=1' -d 'token=glados_network' https://glados.rocks/api/user/checkin

hours=`cat hours.txt`
sudo /bin/echo -e "SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
17 *	* * *	root    cd / && run-parts --report /etc/cron.hourly
25 6	* * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
47 6	* * 7	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6	1 * *	root	test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )
0 $hours * * * ~/crontab/glados/glados.sh > ~/crontab/glados/glados.log 2>&1" > /etc/crontab

hours=`expr $hours - 1`
echo $hours > hours.txt
if [ $hours == -1 ]
then
    echo 23 > hours.txt
fi