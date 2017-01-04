# MAINTAINER        shiluowei <luoweis@126.com>
# DOCKER-VERSION    1.12.3
#
# Dockerizing Mariadb: Dockerfile for building Mariadb images
#
FROM tszins/os/centos/6.7:V001
MAINTAINER shiluowei <luoweis@126.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm

#上传redis软件
ADD redis-3.2.6.tar.gz /usr/local/tszins/
#创建软链接
RUN ln -s /usr/local/tszins/redis-3.2.6 /usr/local/tszins/redis

#安装必须的依赖
RUN yum -y install gcc gcc-c++ tcl
#编译安装
RUN cd /usr/local/tszins/redis && \
make && \
make install
#创建redis目录
RUN mkdir -p /TszinsRedis/conf  && \
mkdir -p /TszinsRedis/log && \
mkdir -p /TszinsRedis/data && \
mkdir -p /TszinsRedis/pid
#上传配置文件
ADD redis.conf /TszinsRedis/conf/

#添加supervisord.conf
ADD supervisord.conf /etc/supervisord.conf

#暴露端口
EXPOSE 22
EXPOSE 9736

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]