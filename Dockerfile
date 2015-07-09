FROM centos:latest

ENV NODE_VERSION 0.6.12
ENV NPM_VERSION 1.1.4
ENV PATH /usr/local/lib/node_modules/:$PATH

RUN buildDeps="gcc gcc-c++ automake autoconf libtoolize make wget" \
    && yum -y update \
    #&& yum -y groupinstall "Development Tools" \
    && yum -y install $buildDeps openssl-devel \
    && mkdir -p /usr/src/node \
    && wget "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz" \
    && tar --strip-components 1 -xzvf node-v* -C /usr/src/node/ \
    && rm node-v*.tar.gz \
    && cd /usr/src/node/ \
    && ./configure \
    && make \
    && make install \
    && ldconfig \
    && rm -rf /usr/src/node \
    && yum remove -y $buildDeps \
    #&& yum groupremove "Development Tools" \
    && yum clean all
    #&& npm cache clear

CMD [ "node" ]
