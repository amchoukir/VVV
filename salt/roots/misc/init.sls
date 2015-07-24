# other packages that come in handy

misc:
  pkg.installed:
    - refresh: True
    - pkgs:
      - imagemagick
      - subversion
      - git-core
      - zip
      - unzip
      - ngrep
      - curl
      - make
      - vim
      - colordiff
      - ntp # ntp service to keep clock current
      - gettext # Req'd for i18n tools
      - dos2unix # Allows conversion of DOS style line endings to something we'll have less trouble with in Linux
      - g++ # nodejs for use by grunt
      - libsqlite3-dev #Mailcatcher requirement

nodejs:
  pkg:
    - installed

npm:
  pkg:
    - installed
    - require:
      - pkg: nodejs

# ack-grep
#
# Install ack-rep directory from the version hosted at beyondgrep.com as the
# PPAs for Ubuntu Precise are not available yet.
/usr/bin/ack:
  cmd.run:
    - name: curl -s http://beyondgrep.com/ack-2.04-single-file > /usr/bin/ack && chmod +x /usr/bin/ack

# COMPOSER
#
# Install Composer if it is not yet available.
composer:
  cmd.run:
    - name: curl -sS https://getcomposer.org/installer | php && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

/usr/local/src/update_composer.sh:
  file.managed:
    - source: salt://misc/update_composer.sh
    - mode: 755
  cmd.run:
    - onlyif:
      - test -e /usr/local/bin/composer


# Graphviz
#
#
## Req'd for Webgrind
graphviz:
  pkg:
    - installed
# Set up a symlink between the Graphviz path defined in the default Webgrind
# config and actual path.
graphviz-webgrind:
  cmd.run:
    - name: ln -sf /usr/bin/dot /usr/local/bin/dot
    - require:
      - pkg: graphviz

# Used to to ensure proper services are started on `vagrant up`
/etc/init/vvv-start.conf:
  file.managed:
    - source: salt://misc/vvv-start.conf
    - mode: 644

/home/vagrant/.bash_profile:
  file.managed:
    - source: salt://misc/bash_profile
    - mode: 644

/home/vagrant/.bash_aliases:
  file.managed:
    - source: salt://misc/bash_aliases
    - mode: 644

/home/vagrant/.vimrc:
  file.managed:
    - source: salt://misc/vimrc
    - mode: 644

/home/vagrant/.subversion/servers:
  file.managed:
    - source: salt://misc/subversion-servers
    - makedirs: True

/home/vagrant/bin/:
  file.recurse:
    - source: salt://misc/homebin

/home/vagrant/.bash_prompt:
  file.managed:
    - source: salt://misc/bash_prompt
    - onlyif:
      - test -e /srv/config/bash_prompt
