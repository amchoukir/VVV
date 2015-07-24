# memcached is made available for object caching
memcached:
  pkg:
    - installed
  service.running:
    - reload: True
    - enable: True
    - watch:
      - file: /etc/memcached.conf
    - reuire:
      - pkg: memcached

/etc/memcached.conf:
  file.managed:
    - source: salt://memcached/memcached.conf
    - mode: 644
