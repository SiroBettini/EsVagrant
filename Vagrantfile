# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Global options
  BOX_NAME = "ubuntu/jammy64"
  # Network options
  PROXY_ENABLE = true
  PROXY_URL = "http://10.20.5.51:8888"
  NO_PROXY = "localhost,127.0.0.1"
  BASE_INT_NET = "10.10.20"
  BASE_HO_NET = "192.168.56"
  # Web VM options
  VM_WEB_NAME = "web\.m340"
  VM_WEB_NET = ".10"
  # DB VM options
  VM_DB_NAME = "db\.m340"
  VM_DB_NET = ".11"

  # Check if a specific plugin i sintalled
  def plugin_installed?(name)
    Vagrant.has_plugin?(name)
  end
  # Check if vagrant-proxyconf is intalled, if not starts the installation
  if PROXY_ENABLE then
    if plugin_installed?('vagrant-proxyconf')
      puts 'vagrant-proxyconf is installed.'
    else
      puts 'vagrant-proxyconf is not installed. Installing...'
      system('vagrant plugin install vagrant-proxyconf')
    end
  end

  ########## VIRTUAL MACHINE WEB ##########
  config.vm.define VM_WEB_NAME do |webconf|
    # Proxy configuration
    if PROXY_ENABLE then
      webconf.proxy.http = PROXY_URL
      webconf.proxy.https = PROXY_URL
      webconf.proxy.no_proxy = NO_PROXY
    end
    # VM Names
    webconf.vm.box = BOX_NAME
    webconf.vm.hostname = VM_WEB_NAME
    # Shared folder
    webconf.vm.synced_folder "./Src", "/var/www/html"
    # Network configuration
    webconf.vm.network "private_network", ip: BASE_HO_NET + VM_WEB_NET
    webconf.vm.network "private_network", ip: BASE_INT_NET + VM_WEB_NET,
      virtualbox__intnet: true
    # VirtualBox configuration
    webconf.vm.provider "virtualbox" do |vb|
      vb.name = VM_WEB_NAME
      vb.gui = true
      vb.memory = "2048"
    end
    # Provisioning
    webconf.vm.provision "shell", path: "./scripts/prov_apache.sh"

    webconf.ssh.insert_key = false
  end

  ########## VIRTUAL MACHINE DB ##########
  config.vm.define VM_DB_NAME do |dbconf|
    # Proxy configuration
    if PROXY_ENABLE then
      dbconf.proxy.http = PROXY_URL
      dbconf.proxy.https = PROXY_URL
      dbconf.proxy.no_proxy = NO_PROXY
    end
    # VM Names
    dbconf.vm.box = BOX_NAME
    dbconf.vm.hostname = VM_DB_NAME
    # Network configuration
    dbconf.vm.network "private_network", ip: BASE_HO_NET + VM_DB_NET
    # VirtualBox configuration
    dbconf.vm.provider "virtualbox" do |vb|
      vb.name = VM_DB_NAME
      vb.gui = true
      vb.memory = "2048"
    end
    # Provisioning
    dbconf.vm.provision "shell", path: "./scripts/prov_mysql.sh"

    dbconf.ssh.insert_key = false
  end
end