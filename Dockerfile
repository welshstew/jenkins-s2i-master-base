FROM registry.access.redhat.com/openshift3/jenkins-1-rhel7:latest

USER root
ENV GROOVY_VERSION 2.4.7
ENV PATH /opt/groovy/bin:$PATH

#download and install groovy
RUN curl -O https://dl.bintray.com/groovy/maven/apache-groovy-binary-${GROOVY_VERSION}.zip && \
    unzip apache-groovy-binary-${GROOVY_VERSION}.zip && \
    mv apache-groovy-${GROOVY_VERSION} /opt/groovy && \
    rm apache-groovy-binary-${GROOVY_VERSION}.zip 

#uid from the jenkins image
USER 1001