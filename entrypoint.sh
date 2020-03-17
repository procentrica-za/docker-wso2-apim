#!/bin/bash
set -e

if [ $WSO2_DOCKER == 'true' ]; then
    echo "WSO2 Docker Container Behaviour"
    sh init.sh "$@"
else
    echo "Override WSO2 Docker Container Behaviour"
    #Edit config files from mustache templates
    if [[ -z $DB_URL || -z $DB_DRIVER || -z $DB_USERNAME || -z $DB_PASSWORD || -z $DB_VALIDATION_QUERY ]]; then
        echo "#################################################"
        echo "########### Using default datasources ###########"
        echo "#################################################"
    else
        echo "#################################################"
        echo "##### Using config template for datasources #####"
        echo "#################################################"
        mo ${WSO2_SERVER_HOME}/templates/master-datasources.xml > ${WSO2_SERVER_HOME}/repository/conf/datasources/master-datasources.xml
    fi

    mo ${WSO2_SERVER_HOME}/templates/api-manager.xml > ${WSO2_SERVER_HOME}/repository/conf/api-manager.xml

    #Start WSO2 API Manager Server
    sh ${WSO2_SERVER_HOME}/bin/wso2server.sh "$@"
fi