# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "2creatives/centos65-x86_64-20140116"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "private_network", ip: "192.168.56.100"
  config.vm.hostname = "skeleton.local"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  config.vm.synced_folder ".", "/synced/"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  config.vm.provider "virtualbox" do |vb|
    vb.name = "vagrant-skeleton"
    vb.memory = "512"
    vb.cpus = 1
  end

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL

  config.vm.provision "shell", inline: <<-SHELL
    cp /synced/.setup/etc/pki/rpm-gpg/* /etc/pki/rpm-gpg/
    cp /synced/.setup/etc/yum.repos.d/* /etc/yum.repos.d/
    yum install -y httpd mod_ssl mysql mysql-server php55w php55w-mysql php55w-bcmath php55w-mbstring php55w-mcrypt php55w-tidy php55w-wddx php55w-pecl-xdebug phpmyadmin

    # autostart
    chkconfig mysqld on
    chkconfig httpd on

    # set mysql root password:
    MYSQL_ROOT_PASSWORD='Toronto'
    service mysqld start
    /usr/bin/mysqladmin -u root password "$MYSQL_ROOT_PASSWORD"

    # some cleanup:
    rm /etc/httpd/conf.d/ssl.conf

    # copy files to overwrite default ones:
    cp -r /synced/.setup/* /

    # set permissions to log file:
    chown apache:apache /var/log/zend_log/stage1/basic.log

    # set symlinks:
    ln -s /usr/share/phpMyAdmin /var/www/phpmyadmin.stage1.natmatch.org
    ln -s /var/www/local.natmatch.org /var/www/stage1.natmatch.org

    # import timezones:
    mysql_tzinfo_to_sql /usr/share/zoneinfo/ | mysql -uroot -p$MYSQL_ROOT_PASSWORD mysql

    # import databases:
    /bin/sh /root/db/import.sh

    # (re)start services:
    service mysqld restart
    service httpd restart
  SHELL
end
