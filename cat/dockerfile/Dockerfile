FROM tomcat:7.0.79-jre7-alpine

# git clone https://gitee.com/hegp/cat.git
# cd cat
# git checkout v3.0.0
# mkdir -p m2
# cp settings.xml m2/
# docker run -it --rm -v "$PWD":/usr/src/mymaven -v "$PWD/m2":/root/.m2 -v "$PWD/target:/usr/src/mymaven/target" -w /usr/src/mymaven maven:3.6.1-jdk-7-alpine mvn install -Dmaven.test.skip=true
# 打包成功后，cat-home/target/cat-alpha-3.0.0.war 是打包后的文件

ENV CATALINA_HOME /usr/local/tomcat
RUN mkdir -p /data/appdatas/cat && \
    mkdir -p /data/applogs/cat && \
    rm -rf $CATALINA_HOME/webapps/*

# cat这个项目，在html写死了刷新的url为/cat/r，所以拷贝进去的war只能命名为cat.war，有点坑

COPY *.war $CATALINA_HOME/webapps/cat.war
ADD datasources.xml /data/appdatas/cat/datasources.xml
ADD setVariable.sh /setVariable.sh

RUN chmod a+x /setVariable.sh

# CMD ["/setVariable.sh", "&&", "/usr/local/tomcat/bin/catalina.sh", "run"]

# CMD ["catalina.sh", "run"]
