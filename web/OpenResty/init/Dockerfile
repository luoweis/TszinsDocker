#
# MAINTAINER        luoweis <luoweis@126.com>
# DOCKER-VERSION    1.12.3
# DATE		2016-12-11
#
# Dockerizing CentOS6: Dockerfile for building CentOS6.7 images
#
FROM       tszins/os/centos/6.7:V001
#Just OpenResty and not install php
MAINTAINER luoweis <luoweis@126.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm
#更新系统
RUN yum clean all && yum makecache && yum -y update

#创建安装路径
RUN mkdir -p /usr/local/tszins
#添加nginx用户
RUN groupadd -r nginx && useradd -s /sbin/nologin -g nginx -r nginx
#安装依赖
RUN yum install -y readline-devel pcre-devel openssl-devel gcc make
#上传安装包
ADD openresty-1.11.2.2.tar.gz /usr/local/tszins
#安装luajit
RUN cd /usr/local/tszins/openresty-1.11.2.2/bundle/LuaJIT-2.1-20161104 && \
        make clean && make && make install && \
        cd /usr/local/tszins/openresty-1.11.2.2/bundle
#上传ngx_cache_purge模块、nginx_upstream_check_module模块
ADD 2.3.tar.gz /usr/local/tszins/openresty-1.11.2.2/bundle
ADD v0.3.0.tar.gz /usr/local/tszins/openresty-1.11.2.2/bundle
#thout-http_redis2_module安装OpenResty
RUN cd /usr/local/tszins/openresty-1.11.2.2 && \
        ./configure --prefix=/usr/local/tszins --with-http_stub_status_module --with-http_gzip_static_module --with-http_realip_module --with-pcre --with-luajit --without-http_redis2_module --with-http_iconv_module --add-module=./bundle/ngx_cache_purge-2.3/ --add-module=./bundle/nginx_upstream_check_module-0.3.0 -j4 && make -j4 && make install
#上传nginx.conf
RUN mv /usr/local/tszins/nginx/conf/nginx.conf /tmp
ADD nginx.conf /usr/local/tszins/nginx/conf
#创建项目
RUN mkdir -p /www/tszins/lua && \
	cp -r /usr/local/tszins/lualib /www/tszins
ADD tszins.conf /www/tszins
ADD main.lua /www/tszins/lua
#添加nginx启动文件
ADD nginx /etc/init.d/nginx
RUN chmod u+x /etc/init.d/nginx
#添加supervisod.conf
ADD supervisord.conf /etc/supervisord.conf

EXPOSE 22
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
