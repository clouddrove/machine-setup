Vagrant.configure("2") do |config|
  NOW = Time.now.strftime("%d.%m.%Y.%H:%M:%S")
  FILENAME = "serial-debug-%s.log" % NOW
  config.vm.define "ubuntu_bionic" do |ubuntu_bionic|
    ubuntu_bionic.vm.provision "shell", path: "./scripts/init_ubuntu.sh", args: "vagrant"
    ubuntu_bionic.vm.box = "ubuntu/bionic64"
  end
  config.vm.define "ubuntu_focal" do |ubuntu_focal|
    ubuntu_focal.vm.provision "shell", path: "./scripts/init_ubuntu.sh", args: "vagrant"
    ubuntu_focal.vm.box = "ubuntu/focal64"
  end
end