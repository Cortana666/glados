# glados
glados自动签到脚本  
---  
签到由原来的获得1天修改为随机点数（5点左右），每累积100点自动兑换为10天。
---
签到结果：
- ~~签到失败，请明天再试（message:Please Try Tomorrow）~~
- ~~签到成功，有效期延长1天（message:Checkin! Get 1 Day）~~
- ~~签到成功，有效期没有延长（message:Checkin! Get 0 day(Your lucky chance is 33%), try next time.）~~
- 签到重复！请明天再试（message:Checkin Repeats! Please Try Tomorrow）
- 签到成功！获得X点点数（message:Checkin! Got X Points）
---
特性：
- 每天不定时签到，防止系统检测
- 会在同目录下生成请求响应日志文件
- 会在同目录下生成签到结果日志文件
- 可手动执行脚本进行签到
---
使用方法：
1. 将COOKIE换为自己登录后的Cookie
2. 执行glados.sh即可自动签到
---
建议安装tmux在后台执行签到脚本
