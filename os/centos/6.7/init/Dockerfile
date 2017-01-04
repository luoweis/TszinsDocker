#
# MAINTAINER        luoweis <luoweis@126.com>
# DOCKER-VERSION    1.12.2
# DATE              2016-12-16
#
# Dockerizing CentOS6: Dockerfile for building CentOS6.7 images
#
FROM       centos:6.7
MAINTAINER luoweis <luoweis@126.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm
RUN cd /etc/yum.repos.d/ && mkdir ./backup && mv ./*.repo ./backup
ADD CentOS6-Base-163.repo /etc/yum.repos.d/base.repo
RUN yum clean all && yum makecache && \
yum install -y openssh-server sudo wget openssh-clients lrzsz vim tmux screen passwd 
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
#添加admin用户密码为@dmin123456
RUN useradd admin
RUN echo "admin:@dmin123456" | chpasswd
RUN echo "admin   ALL=(root) ALL, !/usr/bin/passwd [A-Za-z]*, !/usr/bin/passwd   root" >> /etc/sudoers 
RUN echo "root:P@ssword991120" | chpasswd
#centos6必须配置
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
#启动sshd服务并暴露22端口
RUN mkdir /var/run/sshd
EXPOSE 22
#安装supervisord
RUN yum install -y python-setuptools && \
        easy_install supervisor
RUN echo_supervisord_conf
RUN echo_supervisord_conf > /etc/supervisord.conf
ADD supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
