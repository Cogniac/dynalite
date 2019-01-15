FROM node:10.12-alpine

ENV SERVICE_USER=dynalite
ENV PERSISTENT_DIR=/data/dynalite

COPY .CODEDIR/dynalite /opt/src/dynalite
WORKDIR /opt/src/dynalite
COPY startdynalite.sh /opt/src/dynalite

# Install LevelDB and Node.js
# need to compile leveldb from source using g++
RUN apk add --no-cache --virtual .build-deps \
    mongodb \
    python \
    make \
    g++  \
    && cd /opt/src\ 
    && npm install --unsafe-perm --verbose -g dynalite \
    && npm --force cache clear \
    #&& apk del .build-deps \
    && rm -rf /tmp/* /var/tmp/* 

# Service user and expose dir if you decided to use --path and leveldb
RUN addgroup -g 1001 $SERVICE_USER \
    && adduser -D -G $SERVICE_USER -s /bin/false -u 1001 $SERVICE_USER \
    && mkdir -p $PERSISTENT_DIR \
    && chown -R $SERVICE_USER:$SERVICE_USER $PERSISTENT_DIR

VOLUME ["$PERSISTENT_DIR"]

# Expose a port for the Dynalite server - make sure the shell startup script matches this port
EXPOSE 14567
USER $SERVICE_USER

CMD ["/bin/bash"]
#ENTRYPOINT ["/opt/src/dynalite/startdynalite.sh"]


