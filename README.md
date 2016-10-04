# jenkins-s2i-master-base
OSE jenkins image with a groovy on top

## Building / Deploying

```
oc new-project ci
oc create -f kube/jenkins-s2i-master-base-template.json
REGISTRY=`oc get svc/docker-registry -n default -o json | jq -r .spec.portalIP`
oc new-app --template=jenkins-s2i-master-base -p REGISTRY=$REGISTRY IS_PULL_NAMESPACE=ci


```


### Checking into this...

So with yum install this image end up being quite big...!

```
REPOSITORY                                                                   TAG                 IMAGE ID            CREATED             SIZE
172.30.177.239:5000/fis/jenkins-s2i-base                                     latest              24ad32765651        10 minutes ago      1.263 GB
registry.access.redhat.com/openshift3/jenkins-1-rhel7                        <none>              f7822c4a72eb        2 weeks ago         626.8 MB
```

See recommendations from http://developers.redhat.com/blog/2016/03/09/more-about-docker-images-size/

Maven and Groovy without YUM...
```
REPOSITORY                                                                   TAG                 IMAGE ID            CREATED             SIZE
172.30.177.239:5000/fis/jenkins-s2i-base                                     latest              0f59cbaf32ae        About a minute ago   672.6 MB
registry.access.redhat.com/openshift3/jenkins-1-rhel7                        <none>              f7822c4a72eb        2 weeks ago         626.8 MB
```

### Base Java installs...

Comparing with the fis java openshift image - we are missing the devel package

```
#fis-java
[jboss@fb8c32dc8ba1 bin]$ yum list installed | grep java
ovl: Error while doing RPMdb copy-up:
[Errno 13] Permission denied: '/var/lib/rpm/.dbenv.lock'
java-1.8.0-openjdk.x86_64             1:1.8.0.101-3.b13.el7_2     @jboss-rhel-os
java-1.8.0-openjdk-devel.x86_64       1:1.8.0.101-3.b13.el7_2     @jboss-rhel-os
java-1.8.0-openjdk-headless.x86_64    1:1.8.0.101-3.b13.el7_2     @jboss-rhel-os
javapackages-tools.noarch             3.4.1-11.el7                @jboss-rhel-os
python-javapackages.noarch            3.4.1-11.el7                @jboss-rhel-os
tzdata-java.noarch                    2016f-1.el7                 @jboss-rhel-os

#jenkins-base
sh-4.2$ yum list installed | grep java
ovl: Error while doing RPMdb copy-up:
[Errno 13] Permission denied: '/var/lib/rpm/.dbenv.lock'
java-1.8.0-openjdk.x86_64          1:1.8.0.102-1.b14.el7_2
java-1.8.0-openjdk-headless.x86_64 1:1.8.0.102-1.b14.el7_2
javapackages-tools.noarch          3.4.1-11.el7      @rhel-7-server-rpms
python-javapackages.noarch         3.4.1-11.el7      @rhel-7-server-rpms
tzdata-java.noarch                 2016f-1.el7       @rhel-7-server-rpms

```