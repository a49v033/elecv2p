FROM node:alpine

RUN set -ex \
        && apk update && apk upgrade\
        && apk add --no-cache tzdata curl moreutils git jq vim zip bash perl wget \
        && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && echo "Asia/Shanghai" > /etc/timezone

RUN git clone https://github.com/elecV2/elecV2P.git \
        && cd /elecV2P \
        && yarn install --prod
RUN git clone https://gitee.com/lxk0301/jd_scripts.git /tmp/Shell/scripts \
        && cd /tmp/Shell/scripts \
        && git checkout master \
        && npm install
WORKDIR /elecV2P
EXPOSE 80 8001 8002
RUN mv /elecV2P/script/JSFile/deletelog.js /deletelog.js
ADD gx.sh /gx.sh
RUN chmod +x /gx.sh
ADD task.list /task.list
#CMD ["yarn", "start"]
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
