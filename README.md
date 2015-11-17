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
to freeze your dependencies at their current state and then use this image to build a static binary. It
will fetch all the packages at the commit specified by your godep file and then compile.


Build your binary from your project's root directory:
```bash

docker run -v $PWD:/go/src/app -e BINARY=app rutledgepaulv/godep-vendor-builder

```


Define a next-to-nothing docker container for transport:
```dockerfile

FROM scratch
MAINTAINER Paul Rutledge <paul.v.rutledge@gmail.com>
COPY app /app
ENTRYPOINT [ "/app" ]

```

Build your container with only the binary and push it out for consumption
```
docker build -t rutledgepaulv/app .
docker push rutledgepaulv/app
```
