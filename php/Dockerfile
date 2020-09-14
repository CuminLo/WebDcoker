FROM alpine:latest

LABEL maintainer="CuCuCumin@gmail.com"

ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev dpkg \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkgconf \
		re2c

ENV WORK_DIR="/app" \
    ENVIRON="develop"\
    COMPOSER_MIRROR="https://mirrors.aliyun.com/composer" \
	PHP_FPM_USER="www-data"

RUN set -ex; \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
&& apk --update upgrade --no-cache \
&& apk --update add --no-cache \
    $PHPIZE_DEPS \
    acl \
    ca-certificates \
    curl-dev \
    curl \
    strace \
    ltrace \
    gdb \
    lsof \
    iotop \
    iftop \
    atop \
    htop \
    tcpdump \
    nmap \
    redis \
    man \
    ngrep \
    util-linux \
    libwebp \
    libwebp-dev \
    busybox-extras \
    libmemcached-dev \
    zlib-dev \
    geoip-dev \
    imagemagick-dev \
    openssl-dev \
    bash \
    vim \
    protobuf \
    php7 \
    php7-phalcon \
    php7-dev \
    php7-pear \
    php7-phar \
    php7-bcmath \
    php7-bz2 \
    php7-ctype \
    php7-curl \
    php7-calendar \
	php7-dom \
    php7-exif \
    php7-fpm \
	php7-fileinfo \
    php7-gd \
    php7-gmp \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mysqli \
    php7-mysqlnd \
    php7-opcache \
    php7-openssl \
    php7-pcntl \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    php7-pdo_sqlite \
    php7-pgsql \
    php7-posix \
    php7-pecl-igbinary \
    php7-pecl-msgpack \
    php7-pecl-memcached \
    php7-session \
    php7-soap \
    php7-sockets \
    php7-sysvmsg \
    php7-sysvsem \
    php7-sysvshm \
    php7-sodium \
	php7-simplexml \
    php7-zip \
	php7-zlib \
    php7-tokenizer \
	php7-xml \
	php7-xmlreader \
	php7-xmlwriter \
&& pecl channel-update pecl.php.net \
&& pecl install protobuf && echo "extension=protobuf.so" >> /etc/php7/conf.d/protobuf.ini \
&& pecl install redis && echo "extension=redis.so" >> /etc/php7/conf.d/redis.ini \
&& echo "yes\nyes\n" | pecl install swoole-4.4.0 && echo "extension=swoole.so" >> /etc/php7/conf.d/swoole.ini \
&& echo "yes\n" | pecl install xlswriter && echo "extension=xlswriter.so" >> /etc/php7/conf.d/xlswriter.ini \
## && pecl install yar && echo "extension=yar.so" >> /etc/php7/conf.d/yar.ini \
&& wget -c https://getcomposer.org/composer-stable.phar -O /usr/bin/composer && chmod +x /usr/bin/composer \
&& composer config -g repo.packagist composer ${COMPOSER_MIRROR} \
## && apk del $PHPIZE_DEPS php7-dev \
&& addgroup -g 1000 -S ${PHP_FPM_USER} \
&& adduser -u 1000 -D -S -s /sbin/nologin -G ${PHP_FPM_USER} ${PHP_FPM_USER} \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo "Asia/Shanghai" > /etc/timezone \
&& rm -rf /var/cache/apk/* /tmp/* /var/tmp \
&& mkdir ${WORK_DIR}

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

WORKDIR ${WORK_DIR}

EXPOSE 9000

CMD ["php-fpm7", "-F"]
