#!/bin/sh
#  author Cumin.Lo

restart() {
    /usr/local/bin/php ${SITE_WORK_DIR}/mp/artisan queue:restart
    nohup /usr/local/bin/php ${SITE_WORK_DIR}/mp/artisan queue:work beanstalkd --queue=mp_high_me,mp_middle_me,mp_low_me,mp_default_me --sleep=1 --tries=3 --daemon &
}

restart