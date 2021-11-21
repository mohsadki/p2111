# see https://github.com/cmaessen/docker-php-sendmail for more information

FROM php:php7.2-intl

RUN apt-get update && apt-get install -q -y msmtp mailutils && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mysqli sysvsem

RUN echo "extension=intl" >> /usr/local/etc/php/php.ini-development  
RUN echo "extension=intl" >> /usr/local/etc/php/php.ini-production

RUN pecl install xdebug-3.1.0 \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "[XDebug]" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_log=/tmp/xdebug.log" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini

#RUN echo "hostname=localhost.localdomain" > /etc/msmtp/msmtp.conf \
#    && echo "root=root@localhost" >> /etc/msmtp/msmtp.conf \
#    && echo "mailhub=maildev" >> /etc/msmtp/msmtp.conf \
#    && echo "sendmail_path=sendmail -i -t" >> /usr/local/etc/php/conf.d/php-sendmail.ini

RUN echo "[Date]" >> /usr/local/etc/php/conf.d/php-sendmail.ini \
    && echo "date.timezone = Europe/Amsterdam" >> /usr/local/etc/php/conf.d/php-sendmail.ini

RUN echo "localhost localhost.localdomain" >> /etc/hosts