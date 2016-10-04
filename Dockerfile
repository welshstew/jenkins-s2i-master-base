FROM registry.access.redhat.com/openshift3/jenkins-1-rhel7:latest

USER root
ENV GROOVY_VERSION 2.4.7
ENV PATH /opt/groovy/bin:$PATH

#download and install groovy - changing to local nexus version
RUN curl -O http://10.1.2.4:8081/nexus/service/local/repositories/thirdparty/content/org/groovy/apache-groovy-binary/2.4.7/apache-groovy-binary-2.4.7.zip && \
    unzip apache-groovy-binary-${GROOVY_VERSION}.zip && \
    mv apache-groovy-${GROOVY_VERSION} /opt/groovy && \
    rm apache-groovy-binary-${GROOVY_VERSION}.zip

#uid from the jenkins image
USER 1001