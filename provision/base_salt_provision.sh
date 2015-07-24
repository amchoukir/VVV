#!/usr/bin/env bash

#echo "Setup saltstack PPA"
#sudo apt-get install software-properties-common python-software-properties -y >> /dev/null
#sudo add-apt-repository ppa:saltstack/salt -y >> /dev/null
#sudo apt-get update >> /dev/null
#
#echo "Installing salt-minion"
#sudo apt-get install salt-minion -y >> /dev/null

# By storing the date now, we can calculate the duration of provisioning at the
# end of this script.
start_seconds="$(date +%s)"

if [ ! -d "/etc/salt" ]; then
    echo "Bootstrap salt"
    wget -O - https://bootstrap.saltstack.com | sudo sh
    sudo cp /vagrant/salt/minion /etc/salt/minion

    echo "Restart salt-minion"
    sudo salt-minion -d
    sudo service salt-minion restart
fi

echo "Executing salt highstate (provisionning)"
sudo salt-call state.highstate

end_seconds="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in "$(expr $end_seconds - $start_seconds)" seconds"
