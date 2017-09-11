FROM openresty/openresty:alpine-fat

MAINTAINER Sebastian Ruml <sebastian@sebastianruml.name>

ENV GIT_REPO https://github.com/honewatson/lapis-gke.git

RUN apk add --update \
    openssl-dev bash git \
    && rm /var/cache/apk/*

RUN /usr/local/openresty/luajit/bin/luarocks install lapis
RUN /usr/local/openresty/luajit/bin/luarocks install penlight
RUN /usr/local/openresty/luajit/bin/luarocks install moonscript
RUN /usr/local/openresty/luajit/bin/luarocks install luatz
RUN /usr/local/openresty/luajit/bin/luarocks install stringy
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-auto-ssl
RUN /usr/local/openresty/luajit/bin/luarocks install lapis-exceptions
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-libcjson
RUN /usr/local/openresty/luajit/bin/luarocks install web_sanitize
RUN /usr/local/openresty/luajit/bin/luarocks install cloud_storage
RUN mkdir /app
RUN mkdir /entry

WORKDIR /app

VOLUME /app

ADD ./entry.sh /entry/entry.sh

ENV LAPIS_OPENRESTY "/usr/local/openresty/bin/openresty"

EXPOSE 8080

ENTRYPOINT ["/entry/entry.sh"]

CMD ["server", "production"]
