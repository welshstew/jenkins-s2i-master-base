FROM registry.access.redhat.com/openshift3/jenkins-1-rhel7:latest

USER root

ENV MAVEN_VERSION 3.3.9
ENV GROOVY_VERSION 2.4.0
ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk
ENV GROOVY_HOME /opt/groovy
ENV PATH $GROOVY_HOME/bin:$PATH

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
    mv apache-maven-${MAVEN_VERSION}-bin /opt/maven && \
    rm apache-maven-${MAVEN_VERSION}-bin.tar.gz

#download and install groovy
RUN curl -O http://dl.bintray.com/groovy/maven/groovy-binary-${GROOVY_VERSION}.zip && \
    unzip groovy-binary-${GROOVY_VERSION}.zip && \
    mv groovy-${GROOVY_VERSION} /opt/groovy && \
    rm groovy-binary-${GROOVY_VERSION}.zip 

#uid from the jenkins image
USER 1001