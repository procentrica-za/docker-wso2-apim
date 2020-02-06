FROM wso2/wso2am:2.6.0
MAINTAINER Procentrica

# User Configurations
ARG USER=wso2carbon
ARG USER_ID=802
ARG USER_GROUP=wso2
ARG USER_GROUP_ID=802
ARG USER_HOME=/home/${USER}

#Product Configurations
ARG WSO2_SERVER=wso2am
ARG WSO2_SERVER_VERSION=2.6.0
ARG WSO2_SERVER_PACK=${WSO2_SERVER}-${WSO2_SERVER_VERSION}
ARG WSO2_SERVER_HOME=${USER_HOME}/${WSO2_SERVER_PACK}

USER root

RUN curl -sSLk https://git.io/get-mo -o mo \
    && chmod +x mo \
    && mv mo /bin 

USER ${USER_ID}