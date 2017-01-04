#
# MAINTAINER        shiluowei <luoweis@126.com>
# DOCKER-VERSION    1.12.3
#
# Dockerizing Mariadb: Dockerfile for building Mariadb images
#
FROM tszins/os/centos/6.7:V001
MAINTAINER shiluowei <luoweis@126.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm

#上传软件包：mariadb-10.0.24-linux-x86_64.tar.gz
ADD mariadb-10.1.19-linux-x86_64.tar.gz /usr/local

#添加mysql用户和创建数据目录：

RUN groupadd -r mysql && \
	useradd -s /sbin/nologin -g mysql -r mysql && \
	mkdir -pv /mydata/data && \
	mkdir -pv /mydata/log && \
	mkdir -pv /mydata/bin_log && \
	mkdir -pv /mydata/pid && \
	mkdir -pv /mydata/sock && \
	chown -R mysql:mysql /mydata

#解压并初始化mysql：
RUN yum install -y libaio*
RUN cd /usr/local/ && \
	ln -sv mariadb-10.1.19-linux-x86_64 mysql && \
	cd mysql/ && \
	chown -R root:mysql . && \
	scripts/mysql_install_db --user=mysql --datadir=/mydata/data/

#提供配置文件：

ADD my.cnf /etc/my.cnf


#提供脚本文件：

RUN cp /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld && \
	chkconfig --add mysqld && \
	chkconfig mysqld on

#输出mysql的头文件至系统头文件路径/usr/include：这可以通过简单的创建链接实现

RUN ln -sv /usr/local/mysql/include  /usr/include/mysql


#输出mysql的库文件给系统库查找路径：

RUN echo '/usr/local/mysql/lib' > /etc/ld.so.conf.d/mysql.conf && \
	ldconfig

#修改.bash_profile路径
RUN echo "#MYSQL" >> /etc/profile && \
echo "MYSQL_HOME=/usr/local/mysql" >> /etc/profile && \
echo 'export PATH=$PATH:${MYSQL_HOME}/bin' >> /etc/profile && \
source /etc/profile
#固化mysql的环境变量
ENV MYSQL_HOME /usr/local/mysql
ENV PATH $PATH:${MYSQL_HOME}/bin

#添加supervisord.conf
ADD supervisord.conf /etc/supervisord.conf
#上传modify.sh文件，用来优化数据库及配置root账户的密码和添加tszins的账号
ADD modify.sh /mydata
RUN chmod 755 /mydata/modify.sh

EXPOSE 22
EXPOSE 3306

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
