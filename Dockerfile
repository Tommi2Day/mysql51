FROM ubuntu:22.04 as builder
LABEL AUTHOR=tommi2day

#env
ARG VERSION=5.1.51
ENV DEBIAN_FRONTEND noninteractive

#install dependencies
RUN apt-get update 
RUN apt-get install -q -y build-essential libncurses5-dev bison less vim wget

#add mysql user and sources
RUN groupadd -r mysql && useradd -r -g mysql mysql

#compile mysql51 from source
COPY compile_mysql51.sh /root/
RUN chmod +x /root/compile_mysql51.sh 
RUN /root/compile_mysql51.sh $VERSION

FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive

# install locale and timezone files
RUN apt-get update 
RUN apt-get install -q -y locales tzdata vim less

#add mysql user and sources
RUN groupadd -r mysql && useradd -r -g mysql mysql

#locale
RUN locale-gen de_DE.UTF-8 && locale-gen en_US.UTF-8 && dpkg-reconfigure locales 
#Time
RUN echo "$TZ" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

#add mysql binaries
COPY --from=builder /usr/local/mysql /usr/local/mysql
RUN cp /usr/local/mysql/share/mysql/my-medium.cnf /etc/my.cnf
#add entrypoint
COPY start.sh stop_mysql.sh /root/
RUN chmod +x /root/*.sh

ENV HOSTNAME mysql
ENV TZ Europe/Berlin
ENV TERM linux
ENV PATH /usr/local/mysql/bin:$PATH

#interfaces
EXPOSE 3306

#define entrypoint
ENTRYPOINT ["/root/start.sh"]
CMD ["mysqld_safe"]
