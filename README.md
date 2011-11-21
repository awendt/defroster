# Instant Development Environment From Your WordPress Backup

With this recipe, you get to locally develop on your WordPress site in an instant.

## Prerequisites

1. Backup your WordPress site (files and DB dump) using
   [BackWPup](http://wordpress.org/extend/plugins/backwpup/)
2. Put the latest backup file under `cookbooks/wordpress/files/default/backwpup.tar.gz`
3. Ruby and RubyGems are installed on your machine
4. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
5. `gem install vagrant`

## Getting started

1. `vagrant up` and wait for it to complete (less than 5 minutes on my machine)
2. Point your browser to [http://localhost:8080](http://localhost:8080)
3. `vagrant ssh` into the machine, Apache's docroot is in `/var/www`

## What you could use this for

* Verify your backup works
* Hack on your site when you're offline
* Test something before deploying it
