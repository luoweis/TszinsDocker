#
# MAINTAINER        luoweis <luoweis@126.com>
# DOCKER-VERSION    1.12.3
# DATE		2017.1.3
#
# Dockerizing CentOS6: Dockerfile for building CentOS6.7 images
#
FROM       tszins/web/openresty:TszinsV1
#Just OpenResty and not install php
MAINTAINER luoweis <luoweis@126.com>
ENV TZ "Asia/Shanghai"
ENV TERM xterm
#配置https协议
#上传证书
RUN mkdir /www/tszins/key/
ADD server.crt /www/tszins/key/
ADD server.key /www/tszins/key/
#重新上传tszins.conf
RUN mv /www/tszins/tszins.conf /www/tszins/tszins.conf_`date +%F:%T`
ADD tszins.conf /www/tszins/
#更新main.lua,直接覆盖原先的main.lua
ADD main.lua /www/tszins/lua/

EXPOSE 22
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
