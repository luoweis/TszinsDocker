#
# MAINTAINER        luoweis <luoweis@126.com>
# DOCKER-VERSION    1.9.1
# DATE		2016-4-1
#
# Dockerizing CentOS6: Dockerfile for building php 5.5
#
FROM      10.129.28.74:5000/um/web/openresty/1.9.3.2:V0.1
MAINTAINER luoweis <luoweis@126.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm
#安装依赖关系
RUN yum install -y tar gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers cmake libmcrypt libmcrypt-devel mcrypt mhash pcre-devel
#上传安装源包
ADD AutoInstall_OpenResty_PHP.tar.gz /root
#安装lib库
RUN cd /root/src/ && \
	tar xfz libmcrypt-2.5.7.tar.gz && \
	cd libmcrypt-2.5.7 && \
	./configure --prefix=/usr/local/libmcrypt && \
	make && make install && \
	cd /root
#安装php-5.5
RUN cd /root/src && \
	tar xfz php-5.5.16.tar.gz && \
	cd php-5.5.16 && \
	./configure --prefix=/usr/local/UMweb/OR/php --with-config-file-path=/usr/local/UMweb/OR/php/etc --with-pdo-mysql=mysqlnd --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-mysql-sock=/tmp/mysql.sock --with-freetype-dir=/usr/local --with-jpeg-dir=/usr/local --with-png-dir=/usr/local/ --with-zlib-dir=/usr/local/ --with-zlib --with-curl=/usr/local --enable-mbregex --enable-fpm --enable-mbstring --with-mcrypt=/usr/local/libmcrypt --with-mhash --enable-pcntl --enable-sockets --without-pear --disable-ipv6 --disable-short-tags --with-gd --disable-gd-jis-conv --with-openssl  --enable-inline-optimization --disable-debug && \
	make && make install && \
	sed -i "s/alias cp='cp -i'/#alias cp='cp -i'/g" ~/.bashrc && \
	cd sapi/fpm/&&cp -r -f init.d.php-fpm /etc/init.d/php-fpm&&cd ../../../ && \
	chmod 755 /etc/init.d/php-fpm && \
	cd /root
#安装插件
RUN cd /root/src && \
	tar xfz memcache-3.0.8.tgz && \
	cd memcache-3.0.8&&/usr/local/UMweb/OR/php/bin/phpize && ./configure --with-php-config=/usr/local/UMweb/OR/php/bin/php-config && make && make install && cd /root

RUN cd /root/src && \
	cd ZendOptimizerPlus && /usr/local/UMweb/OR/php/bin/phpize && ./configure --with-php-config=/usr/local/UMweb/OR/php/bin/php-config && make && make install && cd /root

RUN cd /root/src && \
	cd msgpack-php && /usr/local/UMweb/OR/php/bin/phpize && ./configure --with-php-config=/usr/local/UMweb/OR/php/bin/php-config && make && make install && cd /root
RUN cd /root/src && \
	cd yar && /usr/local/UMweb/OR/php/bin/phpize && ./configure --with-php-config=/usr/local/UMweb/OR/php/bin/php-config --enable-msgpack && make && make install && cd /root
RUN cd /root/src && \
	tar xfz yaf-2.2.8.tgz && \
	cd yaf-2.2.8&&/usr/local/UMweb/OR/php/bin/phpize  && ./configure --with-php-config=/usr/local/UMweb/OR/php/bin/php-config && make && make install && cd /root

ADD php.ini /usr/local/UMweb/OR/php/etc/php.ini
ADD php-fpm.conf /usr/local/UMweb/OR/php/etc/php-fpm.conf
ADD nginx.conf /usr/local/UMweb/OR/nginx/conf/nginx.conf_UM
ADD supervisord.conf /etc/supervisord.conf
RUN mkdir -p /data/www


EXPOSE 22
EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
