# This Dockerfile is used to build an image containing the Apache Thrift framework. This image may be used 
# to compile .thrift files. The idea is to extend the user's development environment with a Thrift 
# compiler without any need to alter the user's machine. The generated libraries may be copied back onto a host
# using the Docker's cp command.
FROM ubuntu:xenial

# Set the Thrift version number for this image.
ENV THRIFT_VERSION 0.9.3

# # Set some auxiliary env. variables for later steps.
# # ENV FILE_NAME thrift-$THRIFT_VERSION

# # Download the matching github repo
# RUN apt update
# RUN apt install -y git
# RUN git clone https://github.com/apache/thrift.git
# WORKDIR thrift
# RUN git checkout $THRIFT_VERSION

# # Install all necessary dependencies needed by Thrift.
# RUN apt install -y libboost-dev libboost-test-dev libboost-program-options-dev libboost-system-dev libboost-filesystem-dev libevent-dev automake libtool flex bison pkg-config g++ libssl-dev python-all python-all-dev python-all-dbg php7.0-dev php7.0-cli phpunit

# # Bootstrap and Configure
# RUN ./bootstrap.sh

# # Mount the volume to be used as a primary source folder, where user's thrift IDL files are situated.
# # VOLUME /src/thrift
# # VOLUME /microservices /microservices

# # Compile and Install Thrift.
# RUN ./configure
# RUN make
# RUN make install
# RUN mv /usr/lib/python2.7/site-packages/thrift /usr/lib/python2.7/dist-packages/

# # GENERATE python and php files in microservices file tree
# # RUN cd microservices
# # RUN thrift --gen py:utf8strings rpc.thrift
# # RUN thrift --gen php rpc.thrift
# # RUN python rpc.py

# # Make the thrift.sh as an entry point for this container.
# # COPY thrift.sh thrift.sh
# # RUN chmod +x thrift.sh
# # ENTRYPOINT ["./thrift.sh"]
# # RUN python rpc.py

#Install C++, Java and Python dependencies
RUN apt-get update && \
    apt-get install -y \
        automake \
        bison \
        flex \
        g++ \
        git \
        libboost-all-dev \
        libevent-dev \
        libssl-dev \
        libtool \
        make \
        pkg-config \
        wget \
        \
        ant \
        maven \
        openjdk-8-jdk \
        \
        php7.0-dev \
        php7.0-cli \
        phpunit \
        \
        python-all \
        python-all-dbg \
        python-all-dev \
        python-setuptools \
        python-twisted \
        python-zope.interface \
        python-pip \
        python3-pip && \
    pip install --upgrade backports.ssl_match_hostname && \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/*

#Install Apache Thrift
RUN git clone http://github.com/apache/thrift &&\
    cd thrift &&\
    git checkout $THRIFT_VERSION && \
    ./bootstrap.sh && \
    ./configure && \
    make install && \
    ldconfig

VOLUME /microservices /microservices
