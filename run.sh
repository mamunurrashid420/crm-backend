#!/bin/sh

# Ensure script stops on any error
set -e
cd /app

# Note on composer require, if needed we will use composer require inside docker container, it will update our composer.json file
# Run database migrations
# php artisan db:wipe --database pgsql_auth
php artisan migrate

php artisan optimize

#php artisan migrate:fresh --seed
#php artisan migrate:fresh

# php artisan l5-swagger:generate

php artisan optimize:clear
# php artisan rabbitmq:consume default_consumer > /dev/null &
# Serve the Laravel application, making it accessible from any IP address
php artisan serve --host=0.0.0.0 --port=8000
