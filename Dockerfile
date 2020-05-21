FROM laravel-ecs-base:0.3

LABEL maintainer="qazz92"

COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/default.conf /etc/nginx/conf.d/default.conf
COPY docker/php-fpm.conf /etc/php7/fpm/php-fpm.conf
COPY docker/php.ini /etc/php/7.4/fpm/php.ini
COPY docker/supervisord.conf /etc/supervisord.conf
COPY docker/start-container /usr/bin/start-container

COPY . /var/www

WORKDIR /var/www

ADD docker/crontab /crontab

# Give execution rights on the cron job
RUN chmod 0644 /crontab && \
    /usr/bin/crontab /crontab

RUN composer install --no-ansi --no-interaction --no-progress --no-suggest

RUN chmod +x /usr/bin/start-container && \
    chown -R www:www storage && \
    chown -R www:www bootstrap/cache && \
    chmod -R 777 storage/ && \
    chmod -R 777 bootstrap/cache && \
    composer dump-autoload --optimize

ENTRYPOINT ["start-container"]

EXPOSE 80
