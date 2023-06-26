
FROM fluent/fluentd:v1.6-1
USER root
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
    && gem install faraday -v 1.10.3 \       
    && gem install elasticsearch:'7.13.1' \
    && gem install fluent-plugin-elasticsearch -v 5.0.5 

COPY fluent.conf /fluentd/etc/
USER fluent
CMD ["fluentd", "-c", "/fluentd/etc/fluent.conf"]