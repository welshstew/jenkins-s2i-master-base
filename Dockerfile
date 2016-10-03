FROM registry.access.redhat.com/openshift3/jenkins-1-rhel7:latest

USER root

ENV GROOVY_VERSION 2.4.0
ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk
ENV GROOVY_HOME /opt/groovy

RUN yum -y install wget unzip

#grab the maven repo
#RUN wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo

#grab the epel latest rpm so we can get jq - may be useful later
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \ 
    rpm -Uvh epel-release-latest-7*.rpm && \
    rm epel-release-latest-7*.rpm

#install jq, git
RUN yum -y install jq git apache-maven && \
    yum -y clean all

#download and install groovy
RUN wget http://dl.bintray.com/groovy/maven/groovy-binary-${GROOVY_VERSION}.zip && \
    unzip groovy-binary-${GROOVY_VERSION}.zip && \
    mv groovy-${GROOVY_VERSION} /opt/groovy && \
    rm groovy-binary-${GROOVY_VERSION}.zip 

#uid from the jenkins image
USER 1001