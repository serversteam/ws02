FROM isim/oraclejava:1.8.0_101
MAINTAINER Ivan Sim, ihcsim@gmail.com

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/ihcsim/docker-wso2apim"

ARG APIM_VERSION=${APIM_VERSION:-2.0.0}
RUN wget -P /opt https://s3-us-west-2.amazonaws.com/wso2-stratos/wso2am-${APIM_VERSION}.zip && \
    apt-get update && \
    apt-get install -y zip && \
    apt-get clean && \
    unzip /opt/wso2am-${APIM_VERSION}.zip -d /opt && \
    rm -rf /opt/wso2am-${APIM_VERSION}.zip
rm -rf /opt/wso2am-2.0.0/repository/conf/carbon.xml
rm -rf /opt/wso2am-2.0.0/repository/conf/api-manager.xml

COPY carbon.xml /opt/wso2am-2.0.0/repository/conf/
COPY api-manager.xml /opt/wso2am-2.0.0/repository/conf/

EXPOSE 9443 9763 8243 8280 10397 7711
WORKDIR /opt/wso2am-${APIM_VERSION}
ENTRYPOINT ["bin/wso2server.sh"]
