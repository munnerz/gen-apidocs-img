# Builds Docker image to run brodocs and other doc gen tools
FROM node:7.2-slim
MAINTAINER James Munnelly <james@jetstack.io>

RUN apt-get update && \
	apt-get install -y \
		rsync \
		wget \
		curl \
		git && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Install golang
RUN curl https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz | tar -C /usr/local -xz

ENV GOPATH="/go"
ENV PATH="/usr/local/go/bin:/go/bin:${PATH}"

# Install brodocs
RUN git clone --depth=1 https://github.com/Birdrock/brodocs.git \
	&& cd brodocs \
	&& npm install \
	&& rm -Rf ./documents/* \
	&& chmod -R 777 .
COPY runbrodocs.sh /brodocs

ENV BRODOCS="/brodocs"
ENV PATH="/brodocs:${PATH}"

# Install gen-apidocs
RUN git clone https://github.com/kubernetes-incubator/reference-docs $GOPATH/src/github.com/kubernetes-incubator/reference-docs --branch kubebuilder --depth=1 \
	&& go build -o "$GOPATH/bin/gen-apidocs" github.com/kubernetes-incubator/reference-docs/gen-apidocs \
	&& rm -Rf $GOPATH/src/github.com/kubernetes-incubator/reference-docs

# Add test runner
WORKDIR /go
ENTRYPOINT ["/bin/bash"]
