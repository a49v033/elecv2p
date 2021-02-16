FROM alpine
RUN set -ex \
        && apk update && apk upgrade \
        && apk add tzdata curl moreutils git jq bash perl wget yarn \
        && apk add python3-dev py3-pip py3-cryptography \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone
      
RUN git clone https://gitee.com/lxk0301/jd_scripts.git /tmp/Shell/scripts \
        && cd /tmp/Shell/scripts \
        && git checkout master \
        && yarn
        #&& npm install
RUN git clone https://github.com/elecV2/elecV2P.git \
        && cd /elecV2P \
        && sed -i "s/60000/86400000/g" /elecV2P/func/exec.js \
        && yarn \
        && yarn global add pm2
#修改Shell超时时间为一天

RUN pip3 install requests rsa beautifulsoup4
#安装PY3的一些支持库
WORKDIR /elecV2P
EXPOSE 80 8001 8002
#拷贝JSFile目录
RUN cp -r /elecV2P/script/JSFile /tmp
#拷贝lists目录
RUN cp -r /elecV2P/script/Lists /tmp
#CMD ["yarn", "start"]
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
