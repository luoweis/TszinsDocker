#
# MAINTAINER        luoweis <luoweis@126.com>
# DOCKER-VERSION    1.9.1
# DATE                          2016-4-1
#
# Dockerizing CentOS6: Dockerfile for building memcached images
#
FROM       10.129.28.74:5000/um/os/centos/6.7:V0.1
MAINTAINER luoweis <luoweis@126.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm
#安装依赖 
RUN yum install -y gcc gcc-c++  make perl lrzsz
#上传 libevent memcached
ADD memcached-1.4.25.tar.gz /tmp
ADD libevent-2.0.21-stable.tar.gz /tmp
#安装libevent
RUN cd /tmp/libevent-2.0.21-stable && \
	./configure --prefix=/usr/local/libevent && \
	make && make install 
#安装 memcached
RUN cd /tmp/memcached-1.4.25 && \
	./configure --with-libevent=/usr/local/libevent && \
	make && make install
#添加memcached启动配置文件
ADD memcached /etc/init.d/memcached
RUN chmod u+x /etc/init.d/memcached

EXPOSE 22
EXPOSE 11211
#安装supervisord
ADD supervisord.conf /etc/supervisord.conf
#安装memcached-tool
ADD memcached-tool /usr/local/bin/memcached-tool
RUN chmod u+x /usr/local/bin/memcached-tool

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
