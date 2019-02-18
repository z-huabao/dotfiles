#!/usr/bin/env bash

count=`ps -ef |grep xkeysnail |grep -v "grep" |wc -l`

if [ 0 == $count ];then
    echo -e "\nStart to run xkeysnail\n"
    echo $1 | nohup sudo -S xkeysnail ~/ubuntu-config/others/xkeysrc.py > /tmp/xkeys.out
else
    echo -e "\nWarning: There has $count xkeysnail process now!\n"
fi

echo -e "\nFinish!\n"


# 方法2
#export SUDO_ASKPASS=~/_PWD_TEMP_
#nohup sudo -A xkeysnail ~/ubuntu-config/others/xkeysrc.py > /tmp/xkeys.out

# 然后
# add `gnome-terminal -x bash -c "~/ubuntu-config/others/run-xkey.sh"`
# to gnome-session-properties and create file: ~/_PWD_TEMP_
# 创建密码文件 ~/_PWD_TEMP_, 写入如下内容并添加可执行权限
# #!/usr/bin/env bash
# echo password
