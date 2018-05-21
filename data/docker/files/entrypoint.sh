#!/bin/bash

echo '-----------------------------------'
echo '--> Hi from Wordpress Entrypoint'

if [ -f /app/composer.lock ]; then
  composer update
fi

first_run=/app-temp/.first-run

if [ ! -f $first_run ]; then
  echo '---> Wordpress installed, skipping installation'
fi

# copying and removing stuff
if [ -f $first_run ]; then
  echo '---> Copy to public folder'
  mkdir -p /app/public

  cp /app-temp/{.env,.editorconfig,composer.json,wp-cli.yml,main-config.php} /app/
  cp /app-temp/{index.php,wp-config.php} /app/public/

  if [ ! -f /app/composer.lock ]; then
    # install dependencies
    echo '---> Installing  Wordpress and dependencies'
    composer install
  fi

  if [ -f /app/public/wp/wp-config-sample.php ]; then
    echo '---> Removing sample config'
    rm /app/public/wp/wp-config-sample.php
  fi

  if [ -f /app/public/wp/readme.html ]; then
    echo '---> Removing readme'
    rm /app/public/wp/readme.html
  fi

  if [ ! -f /app/secrets.php ]; then
    echo '---> Creating secrets'
    touch /app/secrets.php && echo '<?php' > /app/secrets.php
    curl -sS https://api.wordpress.org/secret-key/1.1/salt/ >> /app/secrets.php
  fi

  # setup database and user
  echo '---> Installing database with admin'
  install_core="wp core install --url=localhost --title=\"$WP_TITLE\" \
    --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL \
    --allow-root"

  until eval $install_core
  do
    echo '---> Waiting for database, trying again.'
    sleep 5
  done

  echo '---> Wordpress Settings'
  wp option update default_pingback_flag 0 --allow-root
  wp option update default_ping_status 0 --allow-root
  wp option update default_comment_status 0 --allow-root
  wp option update comments_notify 0 --allow-root
  wp option update uploads_use_yearmonth_folders 0 --allow-root
  wp option update permalink_structure /%postname%/ --allow-root

  echo '---> Activate Plugins'
  wp plugin install wp-permalauts --activate --allow-root

  if [ ! -d /app/public/content/plugins/svs-security ]; then
    echo '---> SVS security measures plugin'
    wp plugin install /app-temp/svs-security.zip --activate --allow-root
  fi

  # only for development
  wp plugin install developer --activate --allow-root
  wp plugin install debug-bar --activate --allow-root
  wp plugin install debug-bar-console --activate --allow-root

  rm $first_run
fi

if [ "$#" -eq 0 ]; then
  set /bin/bash
fi

exec "$@"