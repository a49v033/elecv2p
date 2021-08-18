FROM debian
RUN set -ex \
        && mv /var/lib/dpkg/info/ /var/lib/dpkg/info_old/ \
        && mkdir /var/lib/dpkg/info/ \
        && apt-get -y update \
        && apt install -y tzdata curl wget git bash lsb-release gnupg python3 python3-pip python3-distutils \
        && ln -sf /usr/bin/python3 /usr/local/bin/python \
        && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
        && apt-get install -y nodejs \
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
