FROM golang:latest

ENV TERRAFORM_VERSION 0.12.20

RUN apt-get update
RUN apt-get install unzip

RUN wget -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform.zip -d /usr/local/go/bin && \
  rm -f terraform.zip

RUN apt-get install git bash openssl

RUN go get github.com/gruntwork-io/terratest/modules/terraform
RUN go get -u github.com/golang/dep/cmd/dep

WORKDIR $GOPATH/src/github.com/gruntwork-io/terratest/modules/terraform

RUN go install
WORKDIR $GOPATH/src/app/test/