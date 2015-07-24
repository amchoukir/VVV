# Mailcatcher
#
# Installs mailcatcher using RVM. RVM allows us to install the
# current version of ruby and all mailcatcher dependencies reliably.
rvm_version="$(/usr/bin/env rvm --silent --version 2>&1 | grep 'rvm ' | cut -d " " -f 2)"
if [[ -n "${rvm_version}" ]]; then

     pkg="RVM"
     space_count="$(expr 20 - "${#pkg}")" #11
     pack_space_count="$(expr 30 - "${#rvm_version}")"
     real_space="$(expr ${space_count} + ${pack_space_count} + ${#rvm_version})"
     printf " * $pkg %${real_space}.${#rvm_version}s ${rvm_version}\n"
else
     # RVM key D39DC0E3
     # Signatures introduced in 1.26.0
     gpg -q --no-tty --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D39DC0E3
     gpg -q --no-tty --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BF04FF17

     printf " * RVM [not installed]\n Installing from source"
     curl --silent -L https://get.rvm.io | sudo bash -s stable --ruby
     source /usr/local/rvm/scripts/rvm
fi

mailcatcher_version="$(/usr/bin/env mailcatcher --version 2>&1 | grep 'mailcatcher ' | cut -d " " -f 2)"
if [[ -n "${mailcatcher_version}" ]]; then
     pkg="Mailcatcher"
     space_count="$(expr 20 - "${#pkg}")" #11
     pack_space_count="$(expr 30 - "${#mailcatcher_version}")"
     real_space="$(expr ${space_count} + ${pack_space_count} + ${#mailcatcher_version})"
     printf " * $pkg %${real_space}.${#mailcatcher_version}s ${mailcatcher_version}\n"
else
     echo " * Mailcatcher [not installed]"
     /usr/bin/env rvm default@mailcatcher --create do gem install mailcatcher --no-rdoc --no-ri


     /usr/bin/env rvm default@mailcatcher --create do gem install mailcatcher --no-rdoc --no-ri
     /usr/bin/env rvm wrapper default@mailcatcher --no-prefix mailcatcher catchmail
     # /usr/bin/env rvm default@mailcatcher do gem install i18n -v 0.6.11
     # /usr/bin/env rvm default@mailcatcher do gem uninstall i18n -Ix --version '>0.6.11'

fi
