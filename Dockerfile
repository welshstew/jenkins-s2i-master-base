FROM registry.access.redhat.com/openshift3/jenkins-1-rhel7:latest

USER root

ENV MAVEN_VERSION 3.3.9
ENV GROOVY_VERSION 2.4.3
ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk
ENV PATH /opt/apache-maven-${MAVEN_VERSION}/bin:/opt/groovy/bin:$PATH

#RUN yum -y install wget

#grab the maven repo
#RUN wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo

#grab the epel latest rpm so we can get jq - may be useful later
# RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \ 
#     rpm -Uvh epel-release-latest-7*.rpm && \
#     rm epel-release-latest-7*.rpm

# packages required are: oniguruma.x86_64 0:5.9.5-3.el7, jq-1.5-1.el7.x86_64
# http://mirror.unl.edu/epel/7/x86_64/j/jq-1.5-1.el7.x86_64.rpm
# http://mirror.unl.edu/epel/7/x86_64/o/oniguruma-5.9.5-3.el7.x86_64.rpm
#install jq, git
# RUN yum -y install jq git apache-maven && \
#     yum -y clean all

#install maven
RUN curl -O http://mirror.catn.com/pub/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar xf apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mv apache-maven-${MAVEN_VERSION} /opt && \
    rm apache-maven-${MAVEN_VERSION}-bin.tar.gz

#download and install groovy
# NOTE: having to point this at my local nexus because the bintray has a ':' in it :-/
#http://10.1.2.4:8081/nexus/service/local/repositories/thirdparty/content/org/groovy/groovy-binary/2.4.3/groovy-binary-2.4.3.zip
RUN curl -O http://10.1.2.4:8081/nexus/service/local/repositories/thirdparty/content/org/groovy/groovy-binary/${GROOVY_VERSION}/groovy-binary-${GROOVY_VERSION}.zip && \
    unzip groovy-binary-${GROOVY_VERSION}.zip && \
    mv groovy-${GROOVY_VERSION} /opt/groovy && \
    rm groovy-binary-${GROOVY_VERSION}.zip 

#uid from the jenkins image
USER 1001