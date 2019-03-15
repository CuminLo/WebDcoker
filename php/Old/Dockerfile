FROM php:fpm-alpine

ENV CPHALCON_VERSION="3.4.2" \
    SWOOLE_VERSION="4.2.10" \
    REDIS_VERSION="4.2.0" \
    XDEBUG_VERSION="2.7.0beta1" \
    GEOIP_VERSION="1.1.1" \
    IMAGICK_VERSION="3.4.3" \
    YAR_VERSION="2.0.5" \
    MONGODB_VERSION="1.5.3" \
    MSGPACK_VERSION="2.0.3" \
    MEMCACHED_VERSION="3.1.3" \
    EVENT_VERSION="2.4.3" \
    SITE_WORK_DIR="/sites" \
    COMPOSER_MIRROR="https://packagist.laravel-china.org" \
    ENVIRON="develop"

COPY lib/cphalcon-${CPHALCON_VERSION}.tar.gz \
     lib/swoole-${SWOOLE_VERSION}.tgz \
     lib/redis-${REDIS_VERSION}.tgz \
     lib/xdebug-${XDEBUG_VERSION}.tgz \
     lib/geoip-${GEOIP_VERSION}.tgz \
     lib/event-${EVENT_VERSION}.tgz \
     lib/imagick-${IMAGICK_VERSION}.tgz \
     lib/memcached-${MEMCACHED_VERSION}.tgz \
     lib/mongodb-${MONGODB_VERSION}.tgz \
     lib/yar-${YAR_VERSION}.tgz \
     lib/msgpack-${MSGPACK_VERSION}.tgz \ /tmp/

RUN set -ex; \
    wget https://dl.laravel-china.org/composer.phar -O /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
&& apk --update upgrade --no-cache && apk add --no-cache \
    ${PHPIZE_DEPS} \
    linux-headers \
    libc-dev \
    curl-dev \
    pcre-dev \
    libpq \
    postgresql-dev \
    zlib-dev \
    gnupg \
    gd-dev \
    perl-dev \
    acl \
    git \
    shadow \	
    imagemagick-dev \
    imagemagick \
    libcurl \
    libsodium-dev \
    libtool \
    libzip-dev \
    libxml2-dev \
    libstdc++ \
    libevent \
    libevent-dev \
    freetype \
    libpng \
    libjpeg-turbo \
    freetype-dev \
    libpng-dev \
    libwebp-dev \
    libjpeg-turbo-dev \
    jpeg-dev \
    libmcrypt \
    libmcrypt-dev \
    gmp-dev \
    libmemcached-dev \
    gettext-dev \
    bzip2-dev \
    geoip-dev \
    ca-certificates vim busybox-extras \
&& docker-php-ext-configure gd \
    --with-gd \
    --with-sodium \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-webp-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
    NPROC=$(getconf _NPROCESSORS_ONLN) && \
    docker-php-ext-install -j${NPROC} pdo_pgsql gd bcmath pdo_mysql exif sockets gmp soap pcntl zip mysqli calendar \
&& cd /tmp && tar xvzf cphalcon-${CPHALCON_VERSION}.tar.gz \
    && cd cphalcon-${CPHALCON_VERSION}/build \
    && sh install \
    && echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini \
&& cd /tmp && pecl install memcached-${MEMCACHED_VERSION}.tgz && docker-php-ext-enable memcached \
&& cd /tmp && pecl install imagick-${IMAGICK_VERSION}.tgz && docker-php-ext-enable imagick \
&& cd /tmp && pecl install mongodb-${MONGODB_VERSION}.tgz && docker-php-ext-enable mongodb \
&& cd /tmp && pecl install swoole-${SWOOLE_VERSION}.tgz && docker-php-ext-enable swoole \
&& cd /tmp && pecl install redis-${REDIS_VERSION}.tgz && docker-php-ext-enable redis \
&& cd /tmp && pecl install geoip-${GEOIP_VERSION}.tgz && docker-php-ext-enable geoip \
&& cd /tmp && pecl install yar-${YAR_VERSION}.tgz && docker-php-ext-enable yar \
&& cd /tmp && pecl install msgpack-${MSGPACK_VERSION}.tgz && docker-php-ext-enable msgpack \
&& cd /tmp && pecl install xdebug-${XDEBUG_VERSION}.tgz && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.overload_var_dump=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
&& docker-php-source delete \
&& apk del ${PHPIZE_DEPS} \
  gettext-dev \
  re2c freetype-dev jpeg-dev libpng-dev libwebp-dev libjpeg-turbo-dev \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone \
&& mkdir ${SITE_WORK_DIR} \
&& setfacl -R -m u:www-data:rwx ${SITE_WORK_DIR} \
&& setfacl -R -m d:u:www-data:rwx ${SITE_WORK_DIR} \
&& composer config -g repo.packagist composer ${COMPOSER_MIRROR} \
&& rm -rf /var/cache/apk/* /tmp/* /var/tmp /var/www

WORKDIR ${SITE_WORK_DIR}

VOLUME ["${SITE_WORK_DIR}"]

EXPOSE 9000
