# nginx is installed as the default web server
nginx:
  pkg:
    - installed
  service.running:
    - reload: True
    - enable: True
    - require:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/nginx-wp-common.conf
      - file: /etc/nginx/custom-sites/
    - onlyif:
      - test -e /etc/nginx/server.key
      - test -e /etc/nginx/server.csr
      - test -e /etc/nginx/server.crt

# Configuration for nginx
nginx-key:
  cmd.run:
    - name: openssl genrsa -out /etc/nginx/server.key 2048 2>&1
    - unless:
      - test -e /etc/nginx/server.key

nginx-csr:
  cmd.run:
    - name: openssl req -new -batch -key /etc/nginx/server.key -out /etc/nginx/server.csr
    - unless:
      - test -e /etc/nginx/server.csr

nginx-crt:
  cmd.run:
    - name: openssl x509 -req -days 365 -in /etc/nginx/server.csr -signkey /etc/nginx/server.key -out /etc/nginx/server.crt 2>&1
    - unless:
      - test -e /etc/nginx/server.crt

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/nginx.conf
    - mode: 644

/etc/nginx/nginx-wp-common.conf:
  file.managed:
    - source: salt://nginx/nginx-wp-common.conf
    - mode: 644

/etc/nginx/custom-sites/:
  file.recurse:
    - source: salt://nginx/sites
