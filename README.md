# jenkins-s2i-base
OSE jenkins image with a couple of extra yummy layers on top


## Building / Deploying

```

oc create -f kube/jenkins-s2i-base-template.json
REGISTRY=`oc get svc/docker-registry -n default -o json | jq -r .spec.portalIP`
oc new-app --template=jenkins-s2i-base -p REGISTRY=$REGISTRY


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