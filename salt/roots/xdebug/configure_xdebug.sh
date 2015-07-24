# Find the path to Xdebug and prepend it to xdebug.ini
XDEBUG_PATH=$( find /usr -name 'xdebug.so' | head -1 )
tmp=`mktemp`
grep -v 1izend_extension /etc/php5/mods-available/xdebug.ini > $tmp
echo "1izend_extension=\"$XDEBUG_PATH\"" >> $tmp
mv $tmp /etc/php5/mods-available/xdebug.ini

