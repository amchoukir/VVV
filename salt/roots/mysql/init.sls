# mysql is the default database
mysql-server:
  pkg:
    - installed
    - require:
      - file: /etc/mysql/configure_mysql.sh
  service.running:
    - name: mysql
    - reload: True
    - enable: True
    - require:
      - pkg: mysql-server
      - file: /etc/mysql/my.cnf
      - file: /home/vagrant/.my.cnf
      - cmd: /etc/mysql/configure_mysql.sh

/etc/mysql/configure_mysql.sh:
  cmd.wait:
    - watch:
      - pkg: mysql-server
  file.managed:
    - source: salt://mysql/configure_mysql.sh
    - mode: 755

/etc/mysql/my.cnf:
  file.managed:
    - source: salt://mysql/my.cnf
    - mode: 644

/home/vagrant/.my.cnf:
  file.managed:
    - source: salt://mysql/root-my.cnf
    - mode: 644

# IMPORT SQL
#
# Create the databases (unique to system) that will be imported with
# the mysqldump files located in database/backups/
mysql-import:
  cmd.run:
    - name: mysql -u root -proot < /srv/database/init-custom.sql
    - onlyif:
      - test -f /srv/database/init-custom.sql
    - require:
      - pkg: mysql-server

# Setup MySQL by importing an init file that creates necessary
# users and databases that our vagrant setup relies on.
mysql-init:
  cmd.run:
    - name: mysql -u root -proot < /srv/database/init.sql
    - require:
      - cmd: mysql-import

/srv/database/import-sql.sh:
  cmd.run:
    - require:
      - cmd: mysql-init
