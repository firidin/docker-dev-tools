FROM openjdk:8-jre-alpine

ENV FC_LANG="en-US" \
    LC_CTYPE="en_US.UTF8" \
    TZ="Europe/Istanbul" \
    JAVA_MAJOR_VERSION="8"

USER root

RUN apk add --update curl tzdata ttf-dejavu fontconfig openssh mailcap netcat-openbsd tcpdump busybox-extras libmagic \
 && rm /var/cache/apk/*

# Add developer user
RUN addgroup -g 1000 -S developer \
 && adduser -u 1000 -S developer -G developer
 
# Add run script as /opt/run-java/run-java.sh and make it executable
RUN mkdir -p /opt/run-java
COPY run-java.sh /opt/run-java/
COPY DevTools.jar /opt/run-java/
RUN chown -R developer:developer /opt/run-java \
 && chmod -R 755 /opt/run-java
 
# developer user
USER 1000

CMD ["sh", "/opt/run-java/run-java.sh"]