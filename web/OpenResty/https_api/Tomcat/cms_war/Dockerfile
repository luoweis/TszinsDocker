#
# MAINTAINER        luoweis <luoweis@126.com>
# DOCKER-VERSION    1.12.3
# DATE		2016-1-3
#
# Dockerizing CentOS6: Dockerfile for building CentOS6.7 images
#
FROM       tszins/cms/https:V001
#Just OpenResty and not install php
MAINTAINER luoweis <luoweis@126.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm
#上传软件包至 /usr/local/tszins/
ADD apache-tomcat-8.5.9.tar.gz /usr/local/tszins/
ADD jdk-8u111-linux-x64.tar.gz /usr/local/tszins/
#创建软链接
RUN  cd /usr/local/tszins/ && \
ln -s apache-tomcat-8.5.9/ tomcat && \
ln -s jdk1.8.0_111/ jdk
#修改/etc/profile
RUN echo "#JDK" >> /etc/profile && \
echo "JAVA_HOME=/usr/local/tszins/jdk" >> /etc/profile && \
echo "JRE_HOME=/usr/local/tszins/jdk/jre" >> /etc/profile && \
echo 'PATH=$PATH:${JAVA_HOME}/bin:${JRE_HOME}/bin' >> /etc/profile && \
echo 'CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar:${JRE_HOME}/lib'>> /etc/profile && \
echo "export JAVA_HOME JRE_HOME PATH CLASSPATH" >> /etc/profile && \
source /etc/profile
#配置JDK环境变量
ENV JAVA_HOME /usr/local/tszins/jdk
ENV JRE_HOME /usr/local/tszins/jdk/jre
ENV PATH $PATH:${JAVA_HOME}/bin:${JRE_HOME}/bin' >> /etc/profile
ENV CLASSPATH .:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar:${JRE_HOME}/lib
#修改nginx配置文件
ADD nginx.conf /usr/local/tszins/nginx/conf/
ADD tszins.conf /www/tszins/
#修改tomcat配置文件
#ADD server.xml /usr/local/tszins/tomcat/conf/

#添加supervisod.conf
ADD supervisord.conf /etc/supervisord.conf
#处理tomcat webapps/ROOT目录
RUN mv /usr/local/tszins/tomcat/webapps/ROOT /usr/local/tszins/tomcat/webapps/ROOT_BAK
RUN mkdir /usr/local/tszins/tomcat/webapps/ROOT
ADD index.jsp /usr/local/tszins/tomcat/webapps/ROOT
#上传war包
ADD cms-manager-web.war /usr/local/tszins/tomcat/webapps
#对外暴露端口号
EXPOSE 22
EXPOSE 80
EXPOSE 443
EXPOSE 8080

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
