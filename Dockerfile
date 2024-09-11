# Use PHP 8.1 with CLI (Command Line Interface) as the base image
FROM php:8.2-cli
# Change Shell to bash
SHELL ["/bin/bash", "-c"]

# Update the package repository and install the required packages
# - libmcrypt-dev: Library for mcrypt, a symmetric key crypto provider
# - zip & unzip: For handling zip files
# - libpq-dev: Developer library for PostgreSQL database
RUN apt-get update -y && apt-get install -y libmcrypt-dev zip unzip libpq-dev git
# RUN apt-get install -y python3 python3-pip supervisor

# Download and install Composer, a dependency manager for PHP
# Composer will be installed globally in /usr/local/bin
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configure PostgreSQL for PHP with the path where PostgreSQL is installed
# This allows PHP to interface with PostgreSQL databases
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql

# Install the following PHP extensions:
# - pdo: Provides a data-access layer used by many databases
# - pdo_pgsql: PostgreSQL driver for PDO
# - pgsql: PostgreSQL database driver
RUN docker-php-ext-install pdo pdo_pgsql pgsql pdo_mysql
RUN docker-php-ext-install sockets

# Set the working directory inside the container to /app
# Subsequent commands will be run from this directory
WORKDIR /app

# Copy all files from the current directory on the host to /app inside the container
COPY . /app

# Create a directory named "framework"
# RUN mkdir storage/framework
# RUN mkdir storage/framework/cache
# RUN mkdir storage/framework/sessions
# RUN mkdir storage/framework/views

RUN chmod -R 777 storage
RUN chmod -R 777 bootstrap/cache

# Expose port 8000 of the container to the host system
EXPOSE 8000

RUN sed -i -e 's/\r$//' run.sh

# Change the permissions of run.sh to make it executable
RUN chmod 777 ./run.sh

# Setup redis via pecl

# Install composer dependencies
#composer install --no-progress --no-interaction --ignore-platform-reqs

# Execute run.sh when the container starts
# This script should contain the necessary commands to run the application
# Ensure run.sh is present in the local directory and contains appropriate startup commands
CMD ./run.sh
