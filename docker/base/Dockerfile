FROM alpine:3.11

LABEL maintainer="qazz92"

ENV TZ=Asia/Seoul
ENV PHP_DIR=/usr/bin
ENV PHP7_BIN=$PHP_DIR/php7
ENV PHP_BIN=$PHP_DIR/php
ENV PHPXD_BIN=$PHP_DIR/phpxd

# php install
# https://github.com/codecasts/php-alpine
RUN echo "1. php repo 등록 및 기본 설치" && \
    apk add --update wget && \
    wget -O /etc/apk/keys/php-alpine.rsa.pub https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub && \
    apk --update add ca-certificates && \
    echo '@edge http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    echo "@php https://dl.bintray.com/php-alpine/v3.11/php-7.4" >> /etc/apk/repositories && \
    apk add --update \
    bash \
    git \
    ca-certificates \
    curl \
    tzdata \
    make \
    zlib \
    zlib-dev \
    gnu-libiconv@edge && \
    echo "2. php 설치" && \
    apk add --update \
    php7@php \
    php7-fpm@php \
    php7-apcu@php \
    php7-bcmath@php \
    php7-bz2@php \
    php7-calendar@php \
    php7-cgi@php \
    php7-ctype@php \
    php7-curl@php \
    php7-dom@php \
   #php7-fileinfo@php \
    php7-exif@php \
    php7-gettext@php \
    php7-gd@php \
    php7-iconv@php \
    php7-imap@php \
    php7-intl@php \
    php7-json@php \
    php7-ldap@php \
    php7-mbstring@php \
    php7-mysqli@php \
    php7-mysqlnd@php \
    php7-openssl@php \
    php7-pdo@php \
    php7-pdo_mysql@php \
    php7-pdo_pgsql@php \
    php7-pdo_sqlite@php \
    php7-phar@php \
    php7-phpdbg@php \
    php7-pgsql@php \
    php7-posix@php \
    php7-session@php \
   #php7-simplexml@php \
    php7-soap@php \
    php7-sodium@php \
    php7-sqlite3@php \
   #php7-tokenizer@php \
    php7-xdebug@php \
    php7-xml@php \
   #php7-xmlrpc@php \
    php7-xmlreader@php \
   #php7-xmlwriter@php \
    php7-xsl@php \
    php7-zip@php && \
    sed -i -- 's/zend/;zend/g' /etc/php7/conf.d/00_xdebug.ini && \
    echo "php -dzend_extension=xdebug \$@" >> $PHPXD_BIN && \
    chmod +x $PHPXD_BIN && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    echo "3. composer 설치" && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ && \
    ln -s /usr/local/bin/composer.phar /usr/local/bin/composer && \
    composer config -g repos.packagist composer https://packagist.jp && \
    composer global require hirak/prestissimo && \
    rm -rf /var/cache/apk/*

# nginx install
RUN apk update && \
    apk add --update supervisor nginx && \
    adduser -D -g 'www' www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /var/www
