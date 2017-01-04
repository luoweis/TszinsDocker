#
# MAINTAINER        luoweis <luoweis@126.com>
# DOCKER-VERSION    1.12.3
# DATE		2016-12-13
#
# Dockerizing CentOS6: Dockerfile for building php 7.14
#
FROM      tszins/web/openresty:V001
MAINTAINER luoweis <luoweis@126.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm
#安装依赖关系
RUN yum install -y gcc gcc-c++  make zlib zlib-devel pcre pcre-devel  libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers libxslt-devel
#创建相关目录
RUN mkdir -p /usr/local/tszins
#上传php源码包
ADD php-7.0.14RC1.tar.gz  /usr/local/tszins
#编译
RUN cd /usr/local/tszins/php-7.0.14RC1 && \
./configure --prefix=/usr/local/tszins/php \
--with-curl \
--with-freetype-dir \
--with-gd \
--with-gettext \
--with-iconv-dir \
--with-kerberos \
--with-libdir=lib64 \
--with-libxml-dir \
--with-mysqli \
--with-openssl \
--with-pcre-regex \
--with-pdo-mysql \
--with-pdo-sqlite \
--with-pear \
--with-png-dir \
--with-xmlrpc \
--with-xsl \
--with-zlib \
--enable-fpm \
--enable-bcmath \
--enable-libxml \
--enable-inline-optimization \
--enable-gd-native-ttf \
--enable-mbregex \
--enable-mbstring \
--enable-opcache \
--enable-pcntl \
--enable-shmop \
--enable-soap \
--enable-sockets \
--enable-sysvsem \
--enable-xml \
--enable-zip && \
make && make install
#配置文件
RUN cd /usr/local/tszins/php-7.0.14RC1 && \
cp ./php.ini-production /usr/local/tszins/php/lib/php.ini && \
cp /usr/local/tszins/php/etc/php-fpm.conf.default /usr/local/tszins/php/etc/php-fpm.conf && \
cp /usr/local/tszins/php/etc/php-fpm.d/www.conf.default /usr/local/tszins/php/etc/php-fpm.d/www.conf && \
cp -r -f  ./sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm && \
chmod +x /etc/init.d/php-fpm 
#上传nginx 配置文件
RUN cd /usr/local/tszins/nginx/conf && mv nginx.conf nginx.conf_`date +%F`
ADD nginx.conf /usr/local/tszins/nginx/conf
#创建php项目目录
RUN mkdir -p /var/www/tszins_php
ADD tszins.conf /var/www/tszins_php
ADD phpinfo.php /var/www/tszins_php
#上传supervisord.conf
ADD supervisord.conf /etc/supervisord.conf
#对外发布端口号
EXPOSE 22
EXPOSE 8080
EXPOSE 8081

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
