#!/bin/bash
if [ ! -e '/elecV2P/script/Shell/scripts/jd_crazy_joy_coin.js' ]; then
    cp -r /tmp/Shell/scripts /elecV2P/script/Shell
    echo "拷贝仓库代码"
fi
if [ ! -e '/elecV2P/script/JSFile/0body.js' ]; then
    cp -r /tmp/JSFile /elecV2P/script
    echo "拷贝JSFile代码"
fi

if [ ! -e '/elecV2P/script/Lists/task.list' ]; then
    cp -r /tmp/Lists /elecV2P/script
    wget -P /elecV2P/script/Lists -q https://www.armn1.ml/jiaoben/task.list
    echo "拷贝Lists代码"
fi


if [ ! -e '/elecV2P/script/Shell/gx.sh' ]; then
    mv /gx.sh /elecV2P/script/Shell/gx.sh
    echo "拷贝更新代码"
fi
echo "首次启动更新仓库代码和挂机判断"
/elecV2P/script/Shell/gx.sh
cd /elecV2P && pm2 start index.js --name elecV2P
tail -f /dev/null
