# we're bindfs guys here
Vagrant.require_plugin 'vagrant-bindfs'

Vagrant.require_version '>= 1.6.0'

# this just won't work without vagrant-salt
unless Vagrant.has_plugin?("vagrant-salt")
  raise "ERROR: No vagrant-salt plugin found! Please install with: vagrant plugin install vagrant-salt"
end

Vagrant.configure("2") do |config|
  # Every Vagrant virtual environment requires a box to build off of. We use
  # 14.04 for this project
  config.vm.box     = "ubuntu/trusty64"
  config.vm.box_url = "ubuntu/trusty64"

  # setup simple networking things. SSH Agent is forwarded by default, you can
  # easily turn it off
  config.vm.network :private_network, ip: '10.88.88.29sss'
  config.ssh.forward_agent = true

  config.vm.network :forwarded_port, guest: 9200, host: 9200

  # Salt files must go in /srv/salt, so sync that exact directory with our
  # local salt/roots
  config.vm.synced_folder "salt/roots", "/srv/salt/"

  # see if we can use NFS here
  nfs_setting = RUBY_PLATFORM =~ /darwin/ || RUBY_PLATFORM =~ /linux/

  # simple virtualbox config section, most of this comes from the dist config
  # file (with a default of 1024MB of RAM and a vm name of forumed
  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--memory", 1024]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--name", "elasticsearch-intro-pres"]
    v.customize ["modifyvm", :id, "--cpuexecutioncap", '100']
    v.customize ["modifyvm", :id, "--cpus", 1]
  end

  # and run our provisioners! salt gets most things, but there are a few
  # loose ends afterwards and I'd rather solve them with a shell script for now!
  config.vm.provision :salt do |salt|
    salt.minion_config = "salt/minion"
    salt.run_highstate = true
  end
end