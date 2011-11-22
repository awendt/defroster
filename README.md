# Defrost Your WordPress Backup In A Virtual Machine

Defroster helps you restore your WordPress backup in a virtual machine
to locally develop on your site or just to verify your backup.

This wouldn't be possible without [Vagrant](http://vagrantup.com).

## Prerequisites

1. Backup your WordPress site using any plugin that archives your files and the database.
   I use [BackWPup](http://wordpress.org/extend/plugins/backwpup/) for that purpose.

   **Important:** The archive must be a `.tgz` or `.tar.gz` file.
   The `.sql` file must be located top-level in that archive.
2. Copy the backup file to `cookbooks/wordpress/files/default/backwpup.tar.gz`
3. Install Ruby and RubyGems on your machine
4. Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
5. Install Vagrant with `gem install vagrant`

## Getting started

1. Execute the following command in your favorite terminal:

        vagrant up
Be patient and wait for it to complete (takes less than 2 minutes on my machine).

2. Point your browser to [http://localhost:8080](http://localhost:8080) and marvel at your locally running website.
3. If you need shell access, execute the following command to get into the VM:

        vagrant ssh
Your WordPress files are located in `/var/www`, the Apache Virtual Host is configured in `/etc/apache2/sites-enabled/wordpress`.

## What you could use this for

* Verify your backup works
* Hack on your site when you're offline
* Test something before deploying it
