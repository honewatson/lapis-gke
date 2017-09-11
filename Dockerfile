FROM openresty/openresty:alpine-fat

ENV GIT_REPO https://github.com/honewatson/lapis-blogx.git
ENV GIT_DIR /app

RUN apk add --update \
    openssl openssl-dev bash git expat expat-dev \
    && rm /var/cache/apk/*

RUN git clone https://github.com/openresty/lua-cjson && cd lua-cjson && luarocks make && cd ../
RUN /usr/local/openresty/luajit/bin/luarocks install luasec
RUN /usr/local/openresty/luajit/bin/luarocks install luasocket
RUN /usr/local/openresty/luajit/bin/luarocks install lapis
RUN /usr/local/openresty/luajit/bin/luarocks install penlight
RUN /usr/local/openresty/luajit/bin/luarocks install moonscript
RUN /usr/local/openresty/luajit/bin/luarocks install luatz
RUN /usr/local/openresty/luajit/bin/luarocks install stringy
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-auto-ssl
RUN /usr/local/openresty/luajit/bin/luarocks install lapis-exceptions
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-libcjson
RUN /usr/local/openresty/luajit/bin/luarocks install web_sanitize
#RUN /usr/local/openresty/luajit/bin/luarocks install cloud_storage
# Does not work with luajit buiild
RUN mkdir /app
RUN mkdir /entry

WORKDIR /app

VOLUME /app

ADD ./entry.sh /entry/entry.sh
RUN chmod +x /entry/entry.sh

ENV LAPIS_OPENRESTY "/usr/local/openresty/bin/openresty"

EXPOSE 8080

ENTRYPOINT ["/entry/entry.sh"]

CMD ["server", "production"]
