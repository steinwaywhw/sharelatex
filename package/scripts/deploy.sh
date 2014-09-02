#!/bin/sh
sed -i "0,/CRYPTO_RANDOM/s/CRYPTO_RANDOM/$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 64 | head -n 1)/" /etc/sharelatex/settings.coffee
sed -i "0,/CRYPTO_RANDOM/s/CRYPTO_RANDOM/$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 64 | head -n 1)/" /etc/sharelatex/settings.coffee

sudo adduser --system --group --home /var/www/sharelatex --no-create-home sharelatex

mkdir -p /var/log/sharelatex
chown sharelatex:sharelatex /var/log/sharelatex

mkdir -p /var/lib/sharelatex
mkdir -p /var/lib/sharelatex/data/user_files
mkdir -p /var/lib/sharelatex/tmp/uploads
mkdir -p /var/lib/sharelatex/data/compiles
mkdir -p /var/lib/sharelatex/data/cache
mkdir -p /var/lib/sharelatex/tmp/dumpFolder
chown -R sharelatex:sharelatex /var/lib/sharelatex

