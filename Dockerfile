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

#Set default environment variables - These can be overwritten on container creation
ENV WSO2_DOCKER=false
ENV AUTHORIZATION_SERVER=localhost:9443
ENV REVERSE_PROXY_ENABLED=false
ENV STORE_CONTEXT=""

USER root

# copy init script to user home
COPY --chown=wso2carbon:wso2 entrypoint.sh ${USER_HOME}/

RUN curl -sSLk https://git.io/get-mo -o mo \
    && chmod +x mo \
    && mv mo /bin 

USER ${USER_ID}

# Add Libraries
COPY --chown=wso2carbon:wso2 dist/lib ${WSO2_SERVER_HOME}/repository/components/lib/
ADD --chown=wso2carbon:wso2 https://repo1.maven.org/maven2/org/postgresql/postgresql/42.2.9/postgresql-42.2.9.jar ${WSO2_SERVER_HOME}/repository/components/lib/

# Add Dropins
COPY --chown=wso2carbon:wso2 dist/dropins ${WSO2_SERVER_HOME}/repository/components/dropins/

# Add All custom config files
COPY --chown=wso2carbon:wso2 config/conf ${WSO2_SERVER_HOME}/repository/conf

# Add Mustache Templates
COPY --chown=wso2carbon:wso2 config/templates ${WSO2_SERVER_HOME}/templates

# expose ports
EXPOSE 9763 9443 9999 11111 8280 8243 5672 9711 9611 7711 7611 10397 9099

# initiate container and start WSO2 Carbon server
ENTRYPOINT ["/home/wso2carbon/entrypoint.sh"]