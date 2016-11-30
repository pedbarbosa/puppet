#!/bin/bash

# Required package versions
PUPPET_REQ='3.8'
FACTER_REQ='2.4'
DOCKER_REQ='1.10'

function version_gt() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"; }

# Check package versions
if ! PUPPET_VER=`puppet --version 2>&1`; then
    echo 'ERROR: Could not determine Puppet version!'
    echo 'Please ensure puppet >=' $PUPPET_REQ 'is installed.'
    exit 1
else
    if version_gt $PUPPET_REQ $PUPPET_VER || version_gt $PUPPET_REQ '4.0'; then
        echo "ERROR: Detected Puppet version ($PUPPET_VER)!"
        echo "Only Puppet 3 is supported and needs to be higher than $PUPPET_REQ"
        exit 1
    fi
fi

if ! FACTER_VER=`facter --version 2>&1`; then
    echo 'ERROR: Could not determine Facter version!'
    echo 'Please ensure facter >=' $FACTER_REQ 'is installed.'
    exit 1
else
    if version_gt $FACTER_REQ $FACTER_VER; then
        echo "ERROR: Detected Facter version ($FACTER_VER)!"
        echo "Facter higher than $FACTER_REQ is required."
        exit 1
    fi
fi

if ! DOCKER_VER=`docker --version | cut -f 3 -d " " | cut -f 1 -d "," 2>&1`; then
    echo 'ERROR: Could not determine Docker version!'
    echo 'Please ensure docker >=' $DOCKER_REQ 'is installed.'
    exit 1
else
    if version_gt $DOCKER_REQ $DOCKER_VER; then
        echo "ERROR: Detected Docker version ($DOCKER_VER)!"
        echo "Docker higher than $DOCKER_REQ is required."
        exit 1
    fi
fi

# Determine if a puppetmaster is already running locally
if `(echo >/dev/tcp/127.0.0.1/8140) &>/dev/null`; then
    if DOCKER_ID=`docker ps -a | grep "8140/tcp" | awk '{print $1}'`; then
        echo "Found docker container $DOCKER_ID running puppetmaster"
        read -r -p "Do you want to stop and remove container $DOCKER_ID? [y/N] " response
        if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
            echo "Stopping docker container $DOCKER_ID..."
            docker stop $DOCKER_ID >/dev/null
            echo "Removing docker container $DOCKER_ID..."
            docker rm $DOCKER_ID >/dev/null
        else
            echo "Aborting..."
            exit 1
        fi
    else
        echo 'ERROR: There is a process running on port 8140 that is not docker based.'
        netstat -tulpn | grep 8140
        echo 'Please stop and disable it using initd or systemd and try again.'
        exit 1
    fi
fi

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

# All pre-checks done, time to ship out docker container
cd /opt/puppet/docker
docker-compose up -d
DOCKER_EXIT=$?
if [ "$DOCKER_EXIT" -eq 0 ]; then
    echo 'New container was created and is starting. Waiting 5 secs...'
    sleep 5
    echo 'Executing puppet certificate registration, warning for node definition is normal.'
    sudo puppet agent -t -w 5
else
    echo 'ERROR: Docker-compose exited with error code $DOCKER_EXIT'
    exit 1
fi
