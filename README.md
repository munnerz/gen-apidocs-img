# gen-apidocs-img

This repository contains source for a Docker image that is used by the
cert-manager project to generate reference API documentation.

It contains:

* golang
* brodocs
* gen-apidocs

These tools composed together can be used to generate reference documentation
for any Kubernetes API based project.

It is a bit of a mis-mash of tools right now, and will be iterated upon to slim
it down in future.
