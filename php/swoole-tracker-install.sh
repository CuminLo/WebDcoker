#!/bin/sh

DESTTAR='http://resources.swoole-cloud.com/getClient/trial/3.0.0'
MD5HASH='c3b55c6d658af695af8c6f8e17f57203'
SHA1HASH='d0bdd58dc407b8f26854cb22e64c3d9bf5249867'
FILESIZE='11229724'
MAGICSTRING='MTgzNDM='

tmpprefix=.
tmpdest=${tmpprefix}/swoole-tracker
tmpfile=${tmpdest}.tar.gz

fetchtar()
{
    if type wget 2>&1 >/dev/null
    then
        wget $DESTTAR -O ${tmpfile}
    elif type curl 2>&1 >/dev/null
    then
        curl $DESTTAR -o ${tmpfile}
    else
        printf "No supported downloader (wget or curl) found.\n"
        printf "Please install one of them, or manually download\n"
        printf "\n\t${DESTTAR}\n\n"
        printf "as ${tmpfile}"
        exit 22
    fi
}

checktar()
{
    if type stat 2>&1 >/dev/null
    then
        [ x`stat ${tmpfile} -c "%s"` = x$FILESIZE ] || return 1
    fi
    if type sha1sum 2>&1 >/dev/null
    then
        printf "${SHA1HASH}  ${tmpfile}\n" | sha1sum -c - && return 0 || return 1
    elif type md5sum 2>&1 >/dev/null
    then
        printf "${MD5HASH}  ${tmpfile}\n" | md5sum -c - && return 0 || return 1
    else
        printf "Neither sha1sum nor md5sum found,\n"
        printf "downloaded file cannot be verified.\n"
        return 0
    fi
}

extracttar()
{
    mkdir -p ${tmpdest}
    tar -xvf ${tmpfile} -C ${tmpdest}
}

if [ -f ${tmpfile} ]
then
    checktar || rm ${tmpfile}
fi
if [ ! -f ${tmpfile} ]
then
    fetchtar
    checktar ||
    {
        rm ${tmpfile}
        printf "Verification failed, please download again swoole-tracker-install.sh\n"
        exit 22
    }
fi

extracttar
cd ${tmpdest}
echo $MAGICSTRING > ./app_deps/node-agent/magicstring
exec ./deploy_env.sh

