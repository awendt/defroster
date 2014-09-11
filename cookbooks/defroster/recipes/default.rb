execute "apt-get update"
package "apache2"
package "mysql-server"
package "php5"
package "php5-mysql"
package "vim"
package "unzip"

file "/var/www/index.html" do
  action :delete
end

cookbook_file "/tmp/backwpup.tar.gz" do
  source "backwpup.tar.gz"
  action :create_if_missing
end

execute "extract WP archive" do
  command "tar -C /var/www -xzf /tmp/backwpup.tar.gz"
  creates "/var/www/.htaccess"
end

execute "a2enmod rewrite"
execute "a2enmod headers"
execute "a2enmod filter"

cookbook_file "/etc/apache2/sites-available/wordpress" do
  source "wordpress.conf"
  mode "0644"
  action :create_if_missing
end

execute "a2dissite default"
execute "a2ensite wordpress && /etc/init.d/apache2 reload"

additional_lines = <<-EOS
  define('WP_HOME','http://localhost:8080');
  define('WP_SITEURL','http://localhost:8080');
EOS

bash "configure Wordpress for local" do
  code <<-EOS
    cd /var/www
    sed -i -e "s/^define('DB_NAME'.*/define('DB_NAME', 'backwpup_vagrant');/" wp-config.php
    sed -i -e "s/^define('DB_USER'.*/define('DB_USER', 'root');/" wp-config.php
    sed -i -e "s/^define('DB_PASSWORD'.*/define('DB_PASSWORD', '');/" wp-config.php
    sed -i -e "s/^define('DB_HOST'.*/define('DB_HOST', 'localhost');/" wp-config.php
  EOS
end

execute "correct file ownership" do
  command "chown -R root:www-data /var/www"
end

execute "create database" do
  command "mysqladmin -u root create backwpup_vagrant"
  creates "/var/lib/mysql/backwpup_vagrant"
end

bash "restore dump" do
  code "mysql -u root backwpup_vagrant < /var/www/*.sql"
  only_if { %x(mysql -u root -e 'show tables' backwpup_vagrant).empty? }
end

cookbook_file "/tmp/wp_options.sql" do
  source "wp_options.sql"
  action :create_if_missing
end

execute "tweak options to match this VM" do
  command "mysql -u root backwpup_vagrant < /tmp/wp_options.sql > /var/log/wp_options.log"
  creates "/var/log/wp_options.log"
end

directory '/var/www/wp-content/plugins/backwpup/tmp' do
  owner "root"
  group "www-data"
  mode 00664
end

file '/var/www/update-wordpress.sh' do
  owner "root"
  mode 00744
  content <<-EOS
#!/bin/bash

cd /tmp
wget http://wordpress.org/latest.zip
unzip latest.zip
cd /var/www/
cp -avr /tmp/wordpress/* .
EOS
end