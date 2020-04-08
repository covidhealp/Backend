FROM php:7.4-fpm

LABEL maintainer="hola@marcalberga.cat"
LABEL description="PHP service for covidhealp backend"

RUN docker-php-ext-install mysqli pdo pdo_mysql

COPY . /app

WORKDIR /app

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');"

RUN php composer.phar install

EXPOSE 80
