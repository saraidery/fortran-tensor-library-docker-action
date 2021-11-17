FROM alpine:3.14

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY hello.sh /hello.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/hello.sh"]

RUN apk update && apk upgrade

