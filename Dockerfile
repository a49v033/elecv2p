FROM debian:buster-slim
RUN set -ex \
        && apt-get -y update \
        && apt-get -y upgrade \
        && apt install -y tzdata curl wget git bash \
        && apt-get install -y nodejs npm \
        && npm config set unsafe-perm true \
        && npm i -g n \
        && PATH="$PATH" \
        && n latest \
        && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && git clone https://github.com/elecV2/elecV2P.git /usr/local/app \
        && npm install -g npm \
        && cd /usr/local/app && npm install

WORKDIR /usr/local/app
#拷贝JSFile目录
RUN cp -r /usr/local/app/script/JSFile /tmp
#拷贝lists目录
RUN cp -r /usr/local/app/script/Lists /tmp
#拷贝Shell目录
RUN cp -r /usr/local/app/script/Shell /tmp
EXPOSE 80 8001 8002

ENV PATH /usr/local/app/node_modules/.bin:$PATH
#添加变量
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
