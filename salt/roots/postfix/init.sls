postfix:
  pkg:
    - installed
    - require:
      - file: /etc/postfix/configure_postfix.sh

# post install script
/etc/postfix/configure_postfix.sh:
  cmd.wait:
    - watch:
      - pkg: postfix
  file.managed:
    - source: salt://postfix/configure_postfix.sh
    - mode: 755
