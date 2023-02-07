# imagem base
FROM php:5.4-apache

RUN apt-get update
RUN apt-get install -y g++ --force-yes

# habilitando os módulos 'header' e 'rewrite'
RUN ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled

# instalando a extensão 'mbstring'
RUN docker-php-ext-install mbstring

# instalando as extensões 'gd'
RUN apt-get install -y libfreetype6-dev --force-yes
RUN apt-get install -y libgd-dev --force-yes
RUN docker-php-ext-configure gd --with-freetype-dir=/usr
RUN docker-php-ext-install gd exif

# instalando as extensões do 'mysql'
RUN docker-php-ext-install mysql mysqli pdo pdo_mysql

# habilitando o módulo 'rewrite'
RUN a2enmod rewrite

RUN apt-get autoremove -y && apt-get clean all

CMD ["apache2", "-D", "FOREGROUND"]
