FROM registry.access.redhat.com/openshift3/jenkins-1-rhel7:latest

USER root

ENV GROOVY_VERSION 2.4.0

RUN yum -y install wget unzip
#grab the epel latest rpm so we can get jq - may be useful later
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \ 
    rpm -Uvh epel-release-latest-7*.rpm && \
    rm epel-release-latest-7*.rpm

#download and install groovy
RUN wget http://dl.bintray.com/groovy/maven/groovy-binary-${GROOVY_VERSION}.zip && \
    unzip groovy-binary-${GROOVY_VERSION}.zip && \
    mv groovy-${GROOVY_VERSION} /opt/groovy && \
    rm groovy-binary-${GROOVY_VERSION}.zip

#install jq, git, and maven3
RUN yum -y install jq git maven3 && \
    yum -y clean all

#uid from the jenkins image
USER 1001