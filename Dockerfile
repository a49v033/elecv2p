FROM debian:buster-slim
RUN set -ex \
        && apt-get -y update \
        && apt-get -y upgrade \
        && apt install -y tzdata curl wget git bash \
        && echo 'export NVM_DIR="$HOME/.nvm"'                                       >> "$HOME/.bashrc" \
        && echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> "$HOME/.bashrc" \
        && echo '[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # This loads nvm bash_completion' >> "$HOME/.bashrc" \
        && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash \
        && nvm install node \
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
