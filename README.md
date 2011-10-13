
Description
===========

Installs and configures the Git source control management system.  By default the Git client is installed, but the `git::server` recipe provides the infrastructure for serving Git repositories over ssh.

Requirements
============

Platform
--------



Tested on 

* Ubuntu 10.04
* Solaris 10

Data bags named users and git_repos must exist (see USAGE).

Cookbooks
---------

If running on Solaris 10, the system needs to have been bootstrapped to use the publically provided EveryCity IPS/pkg(5) repository at http://s10.pkg.ec.  In the Atalanta Systems environment this is still done manually, and no cookbook or bootstrap mechanism exists for this.

To use the Git cookbook in a Solaris 10 environment as described, you must have the following cookbooks:

* ips
* solaris

These need to be the first two entries on the run list.

The `git::server` recipe depends upon the `users` cookbook.

Attributes
==========

server
------

* `node['git']['user']` - user which owns the Git repositories.  Default is `git`
* `node['git']['repo_dir']` - directory in which git repositories are kept.  Default is `/srv/git`

Usage
=====

default
-------

Installs the Git client.

server
------

Sets up a directory to contain Git repositories, and a user to own them.  The server recipe is driven by two databags - `users`, which is set up in the `users` cookbook and `git_repos`.

The `users` cookbook is used to contain the public key for users that require access to the Git repositories.  For full documentation of the `users` databag, see the `users` cookbook README.  For integration with the `git::server` cookbook, add a `git_key` entry such as the following to each users databag item:

    { "id": "angelo", 
    
    ...
    
    "git_key": {
        "name": "id_rsa", 
        "public":"ssh-rsa AAAAB........"
      }
    
    ....
    
    }


The `git_repos` cookbook is the place where git repositories are defined.  For each repository required, simply create a databag item, containing simply the id tag such as:

    { 
      "id": "haldolium"
    }

This will result in the creation of a bare repository, to which code can be pushed.

Changes/Roadmap
===============

## Future

* Support finer grained access control via gitosis or gitolite
* Create git repositories via an LWRP

## 1.0.0:

* Initial release

License and Author
==================

Author:: Atalanta Systems (<support@atalanta-systems.com>)

Copyright:: 2011, Atalanta Systems Ltd
