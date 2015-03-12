# -*- mode: ruby -*-
# vi: set ft=ruby :

$hostname = 'example.vagrant'

$ansible_dir = 'devops/ansible'
$galaxy_roles_file = 'galaxy_roles.yml'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "intellectsoft/wheezy64"

  # Auto assign IP address and handle it via hosts file
  config.vm.network "private_network", type: "dhcp"
  config.ssh.forward_agent = true

  config.vm.synced_folder ".", "/vagrant", type: "nfs", mount_options: ['rw', 'vers=3', 'tcp', 'fsc' ,'actimeo=2']

  def ansible_defaults(config, vm_name)
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "#{$ansible_dir}/provision.yml"
      ansible.host_key_checking = false
      ansible.sudo = true
      ansible.limit = vm_name
      ansible.verbose='v'
      ansible.groups = {
        "vagrant" => ["vagrant_local", "vagrant_ci"],
      }
    end
  end

  config.vm.define "vagrant_local", primary: true do |node|
    node.vm.hostname = $hostname

    ansible_defaults node, "vagrant_local"

    node.vm.provider "virtualbox" do |vbox|
      vbox.cpus = 2
      vbox.memory = 1024
      vbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
  end

  config.vm.define "vagrant_ci", autostart: false do |node|
    node.hostmanager.include_offline = false

    ansible_defaults node, "vagrant_ci"
  end

  config.vm.provider "virtualbox" do |v|
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  if File.exist?('#{$ansible_dir}/#{$galaxy_roles_file}')
    config.vm.provision :host_shell do |host_shell|
      host_shell.inline = 'ansible-galaxy install -r #{$ansible_dir}/#{$galaxy_roles_file} -p #{$ansible_dir}/roles -f'
    end
  end

  # Configure host manager
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    if vm.id
      `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1]
    end
  end

end
