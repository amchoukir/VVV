echo "Updating Composer..."
COMPOSER_HOME=/usr/local/src/composer composer self-update
COMPOSER_HOME=/usr/local/src/composer composer -q global require --no-update phpunit/phpunit:4.3.*
COMPOSER_HOME=/usr/local/src/composer composer -q global require --no-update phpunit/php-invoker:1.1.*
COMPOSER_HOME=/usr/local/src/composer composer -q global require --no-update mockery/mockery:0.9.*
COMPOSER_HOME=/usr/local/src/composer composer -q global require --no-update d11wtq/boris:v1.0.8
COMPOSER_HOME=/usr/local/src/composer composer -q global config bin-dir /usr/local/bin
COMPOSER_HOME=/usr/local/src/composer composer global update

