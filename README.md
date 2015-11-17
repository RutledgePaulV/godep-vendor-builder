[![Docker Repository on Quay](https://quay.io/repository/rutledgepaulv/godep-vendor-builder/status "Docker Repository on Quay")](https://quay.io/repository/rutledgepaulv/godep-vendor-builder)
[![](https://badge.imagelayers.io/rutledgepaulv/godep-vendor-builder:latest.svg)](https://imagelayers.io/?images=rutledgepaulv/godep-vendor-builder:latest 'Get your own badge on imagelayers.io')

### Godep Vendor Builder

A variant on the publicly available golang image that lets you build statically linked go binaries for placement in a minimal
docker image (like what you get when inheriting scratch). This variant is to support builds that rely on the
experimental vendor dependency management in conjunction with godep for managing particular commits of each
dependency.

[vendor-experiment](https://docs.google.com/document/d/1Bz5-UB7g2uPBdOx-rw5t9MxJwkfpx90cqG9AFL0JAYo/edit)



### Usage

When you've got your project together and compiling okay based on your local packages, then use godep
to freeze your dependencies at their current state:


```bash

go get godep
sudo ln -s $GOPATH/bin/godep /usr/local/bin/godep
export GO15VENDOREXPERIMENT=1

cd $GOPATH/path/to/your/app
godep save

```


That should produce a directory in your project called Godeps that contains a json file which details
the specific commit of each dependency your project is currently using based on what's in your workspace.
Now if you run ```godep get``` should also see a 'vendor' directory. These are the project-specific copy
of the dependencies that you can use without affecting other projects that use those dependencies from your
workspace. This image will use 'godep get' to make sure it uses the commits you specified by freezing your
dependencies.


Build your binary:
```bash

docker run -v $PWD:/go/src/app -e BINARY=app rutledgepaulv/godep-vendor-builder

```


Package your binary in a docker container for transport:
```bash

FROM scratch
MAINTAINER Paul Rutledge <paul.v.rutledge@gmail.com>
COPY app /app
ENTRYPOINT [ "/app" ]

```
