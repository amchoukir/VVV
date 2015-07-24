# PHP5
#
# Our base packages for php5. As long as php5-fpm and php5-cli are
# installed, there is no need to install the general php5 package, which
# can sometimes install apache as a requirement.
php-pkgs:
  pkg.installed:
    - refresh: True
    - pkgs:
      - php5-cli
      - php5-common # Common and dev packages for php
      - php5-dev
      - php5-memcache # Extra PHP modules that we find useful
      - php5-imagick
      - php5-mysql
      - php5-imap
      - php5-curl
      - php-pear
      - php5-gd

php5-fpm:
  pkg:
    - installed
  service.running:
    - reload: True
    - enable: True
    - require:
      - pkg: php5-fpm
    - order: last

/etc/php5/fpm/php5-fpm.conf:
  file.managed:
    - source: salt://php/php5-fpm.conf
    - mode: 644

/etc/php5/fpm/pool.d/www.conf:
  file.managed:
    - source: salt://php/www.conf
    - mode: 644

/etc/php5/fpm/conf.d/php-custom.ini:
  file.managed:
    - source: salt://php/php-custom.ini
    - mode: 644

/etc/php5/fpm/conf.d/opcache.ini:
  file.managed:
    - source: salt://php/opcache.ini
    - mode: 644

/etc/php5/mods-available/xdebug.ini:
  file.managed:
    - source: salt://php/xdebug.ini
    - mode: 644
  cmd.wait:
    - name: php5dismod xdebug
    - require:
      - file: /etc/php5/mods-available/xdebug.ini
      - pecl: xdebug

/etc/php5/mods-available/mailcatcher.ini:
  file.managed:
    - source: salt://rvm/mailcatcher.ini
    - mode: 644
  cmd.wait:
    - name: php5enmod mailcatcher
    - require:
      - file: /etc/php5/mods-available/mailcatcher.ini
      - sls: rvm

php5-mcrypt:
  pkg:
    - installed
  cmd.wait:
    - name: php5enmod mcrypt
    - require:
      - pkg: php5-mcrypt

