rvm:
  file.managed:
    - source: salt://rvm/install_rvm.sh
    - name: /usr/local/rvm/scripts/install_rvm.sh
    - makedirs: True
    - mode: 755
  cmd.run:
    - name: /usr/local/rvm/scripts/install_rvm.sh
    - require:
      - file: /usr/local/rvm/scripts/install_rvm.sh
    - unless:
      - test -e /usr/local/rvm/scripts/rvm

/etc/init/mailcatcher.conf:
  file.managed:
    - source: salt://rvm/mailcatcher.conf
    - mode: 644

mailcatcher:
  service.running:
    - reload: True
    - enable: True
    - onlyif:
      - /usr/bin/env mailcatcher --version
    - watch:
      - file: /etc/init/mailcatcher.conf
