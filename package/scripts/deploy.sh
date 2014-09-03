#!/bin/sh
sudo adduser --system --group --home /var/www/sharelatex --no-create-home sharelatex

mkdir -p /etc/sharelatex

mkdir -p /var/log/sharelatex/web
mkdir -p /var/log/sharelatex/document-updater
mkdir -p /var/log/sharelatex/clsi
mkdir -p /var/log/sharelatex/filestore
mkdir -p /var/log/sharelatex/track-changes
mkdir -p /var/log/sharelatex/docstore
mkdir -p /var/log/sharelatex/chat
mkdir -p /var/log/sharelatex/tags
mkdir -p /var/log/sharelatex/spelling
chown -R sharelatex:sharelatex /var/log/sharelatex

mkdir -p /var/lib/sharelatex/data/user_files
mkdir -p /var/lib/sharelatex/tmp/uploads
mkdir -p /var/lib/sharelatex/data/compiles
mkdir -p /var/lib/sharelatex/data/cache
mkdir -p /var/lib/sharelatex/tmp/dumpFolder
chown -R sharelatex:sharelatex /var/lib/sharelatex

mkdir -p /etc/sv/sharelatex-web
mkdir -p /etc/sv/sharelatex-document-updater
mkdir -p /etc/sv/sharelatex-clsi
mkdir -p /etc/sv/sharelatex-filestore
mkdir -p /etc/sv/sharelatex-track-changes
mkdir -p /etc/sv/sharelatex-docstore
mkdir -p /etc/sv/sharelatex-chat
mkdir -p /etc/sv/sharelatex-tags
mkdir -p /etc/sv/sharelatex-spelling

cp -r /var/www/sharelatex/package/runit/sharelatex* /etc/sv/
chmod -R +x /etc/sv/sharelatex-*
ln -fs /etc/sv/sharelatex-* /etc/service/

cp /var/www/sharelatex/package/config/settings.coffee /etc/sharelatex/settings.coffee
sed -i "0,/CRYPTO_RANDOM/s/CRYPTO_RANDOM/$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 64 | head -n 1)/" /etc/sharelatex/settings.coffee
sed -i "0,/CRYPTO_RANDOM/s/CRYPTO_RANDOM/$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 64 | head -n 1)/" /etc/sharelatex/settings.coffee

