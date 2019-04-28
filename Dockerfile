FROM jenkins/jenkins:lts

# if we want to install via apt
USER root

RUN set -ex && \
apt-get update && \
apt-get install -y make vim ca-certificates apt-transport-https && \
apt-get install -y python python-pip awscli && \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - && \
echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list && \
apt-get update && \
apt-get install -y php5.6 php5.6-mbstring php5.6-dom php5.6-zip && \
php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" && \
php -r "copy('https://composer.github.io/installer.sig', '/tmp/composer-setup.sig');"  && \
php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { echo 'Invalid Composer installer' . PHP_EOL; exit(1); }" && \
php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
rm -f /tmp/composer-setup.php && \
rm -f /tmp/composer-setup.sig


# drop back to the regular jenkins user - good practice
USER jenkins
