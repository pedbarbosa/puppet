puppet
======

puppetmaster on the NUC

Versions:
    facter - 2.4.0-1
    hiera  - 1.3.4-2
    puppet - 3.7.4-2

TODO: add installation instructions

puppetmaster for the cubieboard (deprecated)

first steps:
- apt-get install apache2 git puppet puppet-common puppetmaster puppetmaster-common puppetmaster-passenger vim-puppet
- rm -rf /etc/puppet
- git clone https://github.com/pedbarbosa/puppet /etc/puppet
