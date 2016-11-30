#!/bin/bash

# Check package versions
function version_gt() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"; }

PUPPET_REQ='3.8'
FACTER_REQ='2.4'

if ! PUPPET_VER=`puppet --version 2>&1`; then
    echo 'Could not determine puppet version!'
    echo 'Please ensure puppet >=' $PUPPET_REQ 'is installed.'
    exit 1
else
    if version_gt $PUPPET_VER $PUPPET_REQ; then
        echo $PUPPET_VER 'is higher than 3.8'
    else
        echo $PUPPET_VER 'needs to be higher than 3.8, exiting...'
        exit 1
    fi
fi

#FACTER_VER=`facter --version`
#if version_gt $PUPPET_VER 3.8; then
#   echo $PUPPET_VER 'is higher than 3.8'
#fi
#if version_gt $FACTER_VER 2.4; then
#   echo $FACTER_VER 'is higher than 2.4'
#fi

# Check if repository was delivered at /opt/puppet
if [[ ! -e /opt/puppet/docker/puppetmaster/Dockerfile ]]; then
    echo 'The puppet repository does NOT exist or has NOT been cloned correctly.'
    echo 'Please install it with:'
    echo '    git clone https://github.com/pedbarbosa/puppet /opt/puppet'
    exit 1
fi

# Clear any existing puppet configuration
if [[ -d /var/lib/puppet ]]; then
    echo 'Found existing puppet directory in /var/lib/puppet.'
    echo 'This directory needs to be cleared to reconfigure local puppet agent.'
    read -r -p 'Is it OK to proceed? [y/N] ' response
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
        sudo rm -rf /var/lib/puppet
    else
        echo 'Aborting puppet configuration!'
        exit 1
    fi
fi

# TODO: Check if puppet and facter are at least:
#    facter - 2.4.6-2
#    puppet - 3.8.7-1

# TODO: Rest of commands...
# rm -rf /var/lib/puppet
# cd /opt/puppet/docker
# docker-compose up
# docker-compose start puppet
# sudo puppet agent -t -w 5
