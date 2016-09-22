puppet
======

puppetmaster on the NUC

Using "puppet3" and "facter2" AUR packages, versions:
- facter - 2.4.6-2
- puppet - 3.8.7-1

Installation instructions:
- git clone https://github.com/pedbarbosa/puppet /opt/puppet
- rm -rf /var/lib/puppet
- cd /opt/puppet/docker
- docker-compose up
- docker-compose start puppet
- sudo puppet agent -t -w 5
