#!/usr/bin/env bash

# Postfix
#
# Use debconf-set-selections to specify the selections in the postfix setup. Set
# up as an 'Internet Site' with the host name 'vvv'. Note that if your current
# Internet connection does not allow communication over port 25, you will not be
# able to send mail, even with postfix installed.
echo postfix postfix/main_mailer_type select Internet Site | debconf-set-selections
echo postfix postfix/mailname string vvv | debconf-set-selections

# Disable ipv6 as some ISPs/mail servers have problems with it
tmp=`mktemp`
sudo grep -v inet_protocols /etc/postfix/main.cf > $tmp
sudo echo "inet_protocols = ipv4" >> $tmp
sudo mv $tmp /etc/postfix/main.cf
sudo chmod 644 /etc/postfix/main.cf
