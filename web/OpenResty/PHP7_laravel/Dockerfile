#
# MAINTAINER        luoweis <luoweis@126.com>
# DOCKER-VERSION    1.12.3
# DATE          2016-12-16
#
# Dockerizing CentOS6:  php 7.14
# Dockerinzing laravel: 5.3
#
FROM      tszins/web/php/7:V001
MAINTAINER luoweis <luoweis@126.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm

ADD .composer /root
ADD composer.phar /root
RUN mv /root/composer.phar /usr/local/bin/composer
ADD tszins_laravel.tar.gz /var/www/tszins_php/
RUN mv /var/www/tszins_php/tszins.conf /var/www/tszins_php/tszinsw.conf_bak
ADD tszins.conf /var/www/tszins_php/

#配置参数修改
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g'  /usr/local/tszins/php/lib/php.ini && \
sed -i 's/user = nobody/user = nginx/g'  /usr/local/tszins/php/etc/php-fpm.d/www.conf && \
sed -i 's/group = nobody/group = nginx/g'  /usr/local/tszins/php/etc/php-fpm.d/www.conf

#对外发布端口号
#sshd
EXPOSE 22
#lua
EXPOSE 8080
#laravel
EXPOSE 8081

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]