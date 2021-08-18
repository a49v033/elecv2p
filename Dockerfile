FROM debian:stable-slim
RUN set -ex \
        && sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
        && apt-get -y update \
        && apt-get -y upgrade \
        && apt install -y tzdata curl wget git bash \
        && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
        && apt-get install -y nodejs \
        && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
        
RUN git clone https://github.com/elecV2/elecV2P.git /usr/local/app

RUN cd /usr/local/app && npm install

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
