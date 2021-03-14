#!/bin/bash
echo "开始远程下载elecV2P仓库代码"
git clone https://github.com/elecV2/elecV2P.git /usr/local/app
sed -i "s/60000/0/g" /usr/local/app/func/exec.js
rm -r /usr/local/app/package.json
mv /tmp/package.json /usr/local/app/package.json
echo "开始安装npm依赖"
cd /usr/local/app && npm install
cd /usr/local/app && pm2 start index.js --name elecV2P
tail -f /dev/null
