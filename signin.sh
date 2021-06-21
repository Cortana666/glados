#!/bin/bash
# author:yangjian
# 2021-06-18
# glados sign up

curl -b '_ga=GA1.2.940791902.1623222125; koa:sess=eyJjb2RlIjoiR1NBQUQtV0E0R0wtNEswVzItSkdRUDEiLCJ1c2VySWQiOjg2MzE5LCJfZXhwaXJlIjoxNjQ5MjA3NzkxMDEzLCJfbWF4QWdlIjoyNTkyMDAwMDAwMH0=; koa:sess.sig=2zVHsQ16UsSqQGTh8i4xeTyPNxw; _gid=GA1.2.933171949.1623724563; _gat_gtag_UA_104464600_2=1' -d 'token=glados_network' https://glados.rocks/api/user/checkin
