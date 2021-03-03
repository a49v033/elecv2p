# elecv2p-jd

部署docker

基础镜像：byxiaopeng/elecv2p

``` sh
# 基础使用命令
docker run --restart=always -d --name elecv2p -p 80:80 -p 8001:8001 -p 8002:8002 byxiaopeng/elecv2p

# 使用 镜像及持久化存储
docker run --restart=always -d --name elecv2p -e TZ=Asia/Shanghai -p 80:80 -p 8001:8001 -p 8002:8002 -v /elecv2p/JSFile:/usr/local/app/script/JSFile -v /elecv2p/Store:/usr/local/app/script/Store -v /elecv2p/Lists:/usr/local/app/script/Lists byxiaopeng/elecv2p

# 以上命令仅供参考，根据实际情况更改映射端口/时区/镜像等参数。

# 最终推荐使用命令（最后镜像根据使用平台进行调整）
docker run --restart=always \
  -d --name elecv2p \
  -e TZ=Asia/Shanghai \
  -p 80:80 -p 8001:8001 -p 8002:8002 \
  -v /elecv2p/JSFile:/usr/local/app/script/JSFile \
  -v /elecv2p/Lists:/usr/local/app/script/Lists \
  -v /elecv2p/Store:/usr/local/app/script/Store \
  -v /elecv2p/Shell:/usr/local/app/script/Shell \
  -v /elecv2p/rootCA:/usr/local/app/rootCA \
  -v /elecv2p/efss:/usr/local/app/efss \
  byxiaopeng/elecv2p

# 升级 Docker 镜像。（如果没有使用持久化存储，升级后所有个人数据会丢失，请提前备份）
docker rm -f elecv2p           # 先删除旧的容器
docker pull byxiaopeng/elecv2p     # 再下载新的镜像。镜像名注意要和之前使用的相对应
# 再使用之前的 docker run xxxx 命令重新启动一下
```
