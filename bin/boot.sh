#!/usr/bin/env bash

ruby $HOME/config/htpasswd.rb
erb $HOME/config/nginx.conf.erb > $HOME/config/nginx.conf

mkdir -p $HOME/logs/nginx
touch $HOME/logs/nginx/access.log $HOME/logs/nginx/error.log

(tail -f -n 0 $HOME/logs/nginx/*.log &)

if [ ! -f $HOME/vendor/nginx/sbin/nginx ]; then
  echo "Nginx not found in $HOME/vendor/nginx/sbin/nginx while booting"
  exit 1
fi

exec $HOME/vendor/nginx/sbin/nginx -p $HOME -c $HOME/config/nginx.conf
