FROM daocloud.io/java
ENV APP_NAME @project.build.finalName@.@project.packaging@
ENV APP_VERSION @project.version@
EXPOSE 8080
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone
RUN mkdir /var/log/web
VOLUME ["/var/log/web"]
ADD $APP_NAME $APP_NAME
CMD java -jar $APP_NAME
