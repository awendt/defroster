# Defrost Your WordPress Backup In A Virtual Machine

Defroster helps you restore your WordPress backup in a virtual machine
to locally develop on your site or just to verify your backup.

This wouldn't be possible without [Vagrant](http://vagrantup.com).

## Requirements

1. You backup your WordPress site using any plugin that archives your files and the database.
   I use [BackWPup](http://wordpress.org/extend/plugins/backwpup/) for that purpose.  
   **Important:** The archive must be a `.tgz` or `.tar.gz` file.
   The `.sql` file must be located top-level in that archive.
2. Ruby, RubyGems and the latest version of [VirtualBox](https://www.virtualbox.org/wiki/Downloads) are installed on your machine
3. You copied such a backup archive to `cookbooks/wordpress/files/default/backwpup.tar.gz`

## Getting started

1. Install Vagrant:

        gem install vagrant
2. Build yourself a nice VM with your WordPress:

        vagrant up
Be patient and wait for it to complete (takes less than 2 minutes on my machine).

**That's it!**

Now you can point your browser to [http://localhost:8080](http://localhost:8080) and marvel at your locally running website.

If you need shell access, execute the following command to get into the VM:

        vagrant ssh
Your WordPress files are located in `/var/www`, the Apache Virtual Host is configured in `/etc/apache2/sites-enabled/wordpress`.

## What you could use this for

* Verify your backup works
* Hack on your site when you're offline
* Test something before deploying it

## Your feedback is appreciated!

Here's what you do:

* Give Defroster a try and take the time to [report if your backup is working out-of-the-box](https://github.com/awendt/defroster/wiki)
* If it isn't, please [create an issue](https://github.com/awendt/defroster/issues)
* If you can think of any enhancements, create an issue or send a pull request