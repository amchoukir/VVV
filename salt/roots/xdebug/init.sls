# xdebug
#
# XDebug 2.2.3 is provided with the Ubuntu install by default. The PECL
# installation allows us to use a later version. Not specifying a version
# will load the latest stable.
xdebug:
  pecl.installed:
    - require:
      - pkg: php-pkgs

/etc/php5/configure_xdebug.sh:
  cmd.wait:
    - watch:
      - pecl: xdebug
  file.managed:
    - source: salt://xdebug/configure_xdebug.sh
    - mode: 755
