#!/bin/sh

set -e

sed -i s/'user = nobody'/"user = $PHP_FPM_USER"/g /etc/php7/php-fpm.d/www.conf
sed -i s/'group = nobody'/"group = $PHP_FPM_USER"/g /etc/php7/php-fpm.d/www.conf

setfacl -R -m u:$PHP_FPM_USER:rwx ${WORK_DIR}
setfacl -R -m d:u:$PHP_FPM_USER:rwx ${WORK_DIR}

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm7 "$@"
fi

exec "$@"
