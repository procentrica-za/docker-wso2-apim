FROM wso2/wso2am:2.6.0
MAINTAINER Procentrica

RUN curl -sSLk https://git.io/get-mo -o mo \
    && chmod +x mo \
    && mv mo /bin 