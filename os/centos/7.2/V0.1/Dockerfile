#
# MAINTAINER        luoweis <luoweis@126.com>
# DOCKER-VERSION    1.12.3
# DATE                          2016-12-10
#
# Dockerizing CentOS7: Dockerfile for building CentOS7.2 1533 images
#
FROM       os/centos/7.2
MAINTAINER luoweis <luoweis@126.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm
#ADD aliyun_epel.repo /etc/yum.repos.d/epel.repo
RUN yum install -y openssh-server sudo
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
#添加admin用户密码为admin
RUN echo "root:P@ssword991120" | chpasswd
#centos6必须配置
#RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
#RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
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
