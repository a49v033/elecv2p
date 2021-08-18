FROM debian
ADD requirements.txt /root/requirements.txt
RUN set -ex \
        && mv /var/lib/dpkg/info/ /var/lib/dpkg/info_old/ \
        && mkdir /var/lib/dpkg/info/ \
        && apt-get -y update \
        && apt install -y tzdata curl wget git bash lsb-release gnupg gcc g++ make libgl1-mesa-glx libglib2.0-dev procps python3 python3-pip python3-distutils \
        gconf-service libasound2 libatk1.0-0 libatk-bridge2.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc-s1 libgconf-2-4 libgdk-pixbuf2.0-0 \
        libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 \
        libxi6 libxrandr2 libxrender1 libxss1 libxtst6 fonts-liberation libnss3 lsb-release xdg-utils \
        && ln -sf /usr/bin/python3 /usr/local/bin/python \
        && pip install -r /root/requirements.txt \
        && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
        && apt-get install -y nodejs \
        && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
        && git config --global pull.ff only \
        && git clone https://github.com/elecV2/elecV2P.git /usr/local/app \
        && npm install -g npm \
        && cd /usr/local/app \ 
        && npm install \
        && rm -rf /root/.npm \
        && rm -rf /root/.cache 

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
