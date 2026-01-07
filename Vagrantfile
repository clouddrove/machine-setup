# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Use Ubuntu 22.04 LTS
  config.vm.box = "ubuntu/jammy64"
  config.vm.hostname = "devops-test"

  # VirtualBox provider settings
  config.vm.provider "virtualbox" do |vb|
    vb.name = "devops-machine-setup"
    vb.memory = "4096"
    vb.cpus = 2
    vb.gui = false
  end

  # Network configuration
  config.vm.network "private_network", ip: "192.168.56.10"

  # Sync current directory to /vagrant in VM
  config.vm.synced_folder ".", "/vagrant"

  # Provisioning: Install prerequisites
  config.vm.provision "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive
    
    # Update system
    apt-get update
    apt-get upgrade -y
    
    # Install prerequisites
    apt-get install -y \
      git \
      ansible \
      python3 \
      python3-pip \
      sudo \
      curl \
      wget
    
    # Create a user with sudo (if needed)
    # useradd -m -s /bin/bash vagrant || true
    # usermod -aG sudo vagrant || true
    
    echo "✅ Prerequisites installed!"
    echo "📁 Project files are in /vagrant"
    echo "🚀 Run: cd /vagrant && make setup"
  SHELL

  # Post-up message
  config.vm.post_up_message = <<-MESSAGE
    ========================================
    DevOps Machine Setup - Vagrant VM
    ========================================
    
    VM is ready! To test the playbook:
    
    1. SSH into the VM:
       vagrant ssh
    
    2. Navigate to project:
       cd /vagrant
    
    3. Run the playbook:
       make setup
    
    Files are synced from your Mac to /vagrant
    ========================================
  MESSAGE
end

