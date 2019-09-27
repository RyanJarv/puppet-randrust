# randrust

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with randrust](#setup)
    * [What randrust affects](#what-randrust-affects)
    * [Beginning with randrust](#beginning-with-randrust)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference](./REFERENCE.md)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
    * [OSx Install Example](#osx-install-example)
    * [Unit Tests](#unit-tests)
    * [Test Kitchen](#test-kitchen)
    * [Acceptance Tests](#acceptance-tests)
6. [Contributor's/Reference's](#contributors/references)

## Description

Puppet module for installing and configuring [randrust](https://github.com/RyanJarv/randrust) a rust web app that returns a random base64 encoded string of a given length.

After the app is setup it will respond to requests at the endpoint /key/(int) where int is the plaintext length.

Only ubuntu 16.04, 18.04 and debian 9 are tested and supported currently.

## Setup

### What randrust affects

* Setups up an additional apt repository for https://packagecloud.io/jarv/test.
* Installs the randrust package from the above repo.

## Usage


This module will work with the default settings so all that is needed is to include
the randrust class.

```
include randrust
```

If you just want to test this repo out you can use this module as is to configure a
local node with vagrant. See [Developing](#Developing) section for more info.

## Reference

See [REFERENCE](./REFERENCE.md)

## Limitations

### OS support
* Ubuntu 18.04
* Ubuntu 16.04
* Debian 9

### Future Supported Parameters
The following parameters or are not usefull in practice currently. This will
change if/when the randrust package adds support for them.

* interface
* service_provider
* service_name

## Development

This module uses kitchen terraform for testing. To set this up the following things
need to be installed.

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [Ruby](https://rvm.io/) (Preferably a somewhat recent version)
* [Bundler](https://bundler.io/)

### OSx Install Example
```
# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew cask install virtualbox
brew cask install vagrant
brew cask install ruby
gem install bundler

# Setup ruby path each time you need it
export PATH="/usr/local/opt/ruby/bin:$PATH

# Or add it to your profile and open a new terminal window
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile

git clone https://github.com/RyanJarv/puppet-randrust.git

cd puppet-randrust

bundle install --path vendor/bundle
```

### Unit tests

Runs on your local machine, faster then Test Kitchen or acceptance tests.

```
./scripts/unit_tests.sh 
```

### Test Kitchen

This converges and runs [serverspec](https://github.com/RyanJarv/puppet-randrust/blob/master/test/integration/base/serverspec/randrust_spec.rb) tests against a local VirtualBox VM.

Initial setup is slower then unit tests but subsequent runs are about the same.


#### List all nodes
```
bundle exec kitchen list
Instance                Driver   Provisioner  Verifier  Transport  Last Action    Last Error
base-ubuntu18-randrust  Vagrant  PuppetApply  Busser    Sftp       <Not Created>  <None>
base-ubuntu16-randrust  Vagrant  PuppetApply  Busser    Sftp       <Not Created>  <None>
base-debian-randrust    Vagrant  PuppetApply  Busser    Sftp       <Not Created>  <None>
```

#### Converge and run serverspec's against a specific node
This can be rerun as you make changes untill it succeeds.
```
bundle exec kitchen verify base-ubuntu18-randrust
-----> Starting Kitchen (v2.3.3)
-----> Creating <base-ubuntu18-randrust>...
       Bringing machine 'default' up with 'virtualbox' provider...
       ==> default: Importing base box 'ubuntu/bionic64'...
==> default: Matching MAC address for NAT networking...
...
```

Once your done use `bundle exec kitchen destroy` to shutdown the VM's.

#### Acceptance tests
Will run the destroy/create/test/destroy process for all machines. Run this at least once before you make a PR.

```
bundle exec kitchen test
```

Afterwards if all nodes show as not created in `bundle exec kitchen list` then the run succeeded.

#### Generating REFERENCE.md
This uses (puppet-strings)[https://puppet.com/docs/puppet/5.5/puppet_strings.html#reference-4095] to create the reference file.

```
 ./scripts/generate_references.sh 
Files:                    4
Modules:                  0 (    0 undocumented)
Classes:                  0 (    0 undocumented)
Constants:                0 (    0 undocumented)
Attributes:               0 (    0 undocumented)
Methods:                  0 (    0 undocumented)
Puppet Defined Types:     0 (    0 undocumented)
Puppet Functions:         0 (    0 undocumented)
Puppet Data Types:        0 (    0 undocumented)
Puppet Data Type Aliases:     0 (    0 undocumented)
Puppet Tasks:             0 (    0 undocumented)
Puppet Types:             0 (    0 undocumented)
Puppet Providers:         0 (    0 undocumented)
Puppet Plans:             0 (    0 undocumented)
Puppet Classes:           4 (    0 undocumented)
 100.00% documented
 ```


## Contributor's/Reference's

Code used as reference for this module is listed here along with the license of the project.

* [scoopex/puppet-kitchen_template](https://github.com/scoopex/puppet-kitchen_template)
  * Reference for implementing Test Kitchen in a puppet module (typically this is used with chef).
  * [BSD-2](https://github.com/scoopex/puppet-kitchen_template/blob/master/LICENSE)
* [puppetlabs/puppetlabs-ntp](https://github.com/puppetlabs/puppetlabs-ntp)
  * Reference for implementing a typical service in puppet.
  * [Apache-2.0](https://github.com/puppetlabs/puppetlabs-ntp/blob/master/LICENSE)
* [Puppet Development Kit](https://puppet.com/docs/pdk/1.x/pdk.html)
  * Scaffolding for module, manifests and unit tests.
  * [Apache-2.0](https://github.com/puppetlabs/pdk/blob/master/LICENSE)

The rest is written by [RyanJarv](https://github.com/RyanJarv) and licensed under [BSD-2](https://github.com/RyanJarv/randrust/LICENSE)