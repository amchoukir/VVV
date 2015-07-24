include:
  - misc

# TODO: Add the source repo
nodejs_repo:
  pkgrepo.managed:
    - humanname: NodeJs Repo
    - keyid: C7917B12
    - keyserver: keyserver.ubuntu.com
    - dist: trusty
    - name: deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu trusty main
    - file: /etc/apt/sources.list.d/nodejs.list
    - require_in:
      - pkg: nodejs

# TODO: Add the source repo
nginx_repo:
  pkgrepo.managed:
    - humanname: Nginx Repo
    - keyurl: http://nginx.org/keys/nginx_signing.key
    - dist: trusty
    - require_in:
      - pkg: nginx
    - name: deb http://nginx.org/packages/mainline/ubuntu/ trusty nginx
    - file: /etc/apt/sources.list.d/nginx.list
