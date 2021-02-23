FROM php:7.3-apache
RUN apt-get update && \
    apt-get install php7.2 php7.2-curl php7.2-dev php7.2-gd php7.2-intl php7.2-bcmath \
                    php7.2-json php7.2-mbstring php7.2-mysql php7.2-xml php7.2-zip && \
    apt-get install php-pear && \
    pecl install mongodb && \
    echo "extension=mongodb.so" > /etc/php/7.2/mods-available/mongodb.ini && \
    phpenmod mongodb
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');"
