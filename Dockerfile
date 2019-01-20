FROM ubuntu:precise
MAINTAINER stv

# docker build -t stv/catcha .

ADD ./install.sh /root/install.sh
ADD ./install-gvm.sh /root/install-gvm.sh
ENV HOME /root
WORKDIR /root
RUN /root/install.sh
EXPOSE 8080

# CMD ["grails", "run-app"]

