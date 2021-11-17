FROM alpine:3.14

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY hello.sh /hello.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/hello.sh"]

RUN apk update && apk upgrade

RUN apk add --no-cache vim
RUN apk add --no-cache git
RUN apk add --no-cache gcc
RUN apk add --no-cache gfortran
RUN apk add --no-cache g++
RUN apk add --no-cache cmake
RUN apk add --no-cache ninja
RUN apk add --no-cache python3
RUN apk add --no-cache make

# BLAS & LAPACK libraries
RUN apk add --no-cache blas-dev
RUN apk add --no-cache lapack-dev

# pFUnit
RUN apk add --no-cache m4
WORKDIR /
RUN git clone --recursive https://github.com/Goddard-Fortran-Ecosystem/pFUnit.git 
WORKDIR /pFUnit
RUN git checkout tags/v4.2.1 -b v4.2.1
WORKDIR /pFUnit/build 
RUN cmake -D CMAKE_BUILD_TYPE=Release \
    -D SKIP_ESMF=ON \
    -D SKIP_MPI=ON \
    -D SKIP_FHAMCREST=ON \
    -D SKIP_ROBUST=YES \
    -D ENABLE_TESTS=OFF .. 
RUN make 
RUN make install

