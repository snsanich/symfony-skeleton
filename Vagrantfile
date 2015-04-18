# -*- mode: ruby -*-
# vi: set ft=ruby :

ansible_dir = 'devops/ansible'
galaxy_roles_file = "#{ansible_dir}/galaxy_roles.yml"

# Node configs
# Specify name and hostname for node
nodes = [
  {:name => 'local', :hostname => 'example.vagrant', :primary => true},
  {:name => 'ci', :hostname => 'example.vagrant', :primary => false}
]

# <editor-fold desc="Check Vagrant version and installed plugins" defaultstate="collapsed">
# Check vagrant version
if Vagrant::VERSION < "1.7.0"
  puts "Please upgrade to vagrant 1.7+: "
  puts "http://www.vagrantup.com/downloads.html"
  puts
  exit
end

def require_plugin(name)
  unless Vagrant.has_plugin?(name)
    puts <<-EOT.strip
      #{name} plugin required. Please run: "vagrant plugin install #{name}"
    EOT
    exit
  end
end

require_plugin 'vagrant-host-shell'
require_plugin 'vagrant-hostmanager'
require_plugin 'vagrant-vbguest'

# </editor-fold>

# <editor-fold desc="Utilities for system info retrieval" defaultstate="collapsed">
def set_vm_settings(config, min_cpu, min_memory)

  host = RbConfig::CONFIG['host_os']

  # Give VM 1/4 system memory on the host
  if host =~ /darwin/
    cpus = `sysctl -n hw.ncpu`.to_i / 2
    mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
  elsif host =~ /linux/
    # meminfo shows KB and we need to convert to MB
    cpus = `nproc`.to_i / 2
    mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
  else
    cpus = min_cpu
    mem = min_memory
  end

  config.cpus = [cpus, min_cpu].max
  config.memory = [mem, min_memory].max
end
# </editor-fold>

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Our base Debian Wheezy64 image
  config.vm.box = "intellectsoft/wheezy64"

  # Auto assign IP address and handle it via hosts file
  config.vm.network "private_network", type: "dhcp"
  config.ssh.forward_agent = true

  # Disable guest additions update
  config.vbguest.auto_update = false

  # Configure NFS shared folders
  config.vm.synced_folder(
    ".", "/vagrant",
    type: "nfs",
    mount_options:  %w(rw vers=3 tcp fsc actimeo=2)
  )

  # Define VM nodes
  nodes.each do |node|
    config.vm.define node[:name], autostart: node[:primary], primary: node[:primary] do |node_config|
      node_config.vm.hostname = node[:hostname]

      # Setup Ansible provisioning
      node_config.vm.provision "ansible" do |ansible|
        ansible.playbook = "devops/ansible/provision.yml"
        ansible.host_key_checking = false
        ansible.sudo = true
        ansible.limit = node[:name]
        ansible.groups = {"vagrant" => nodes.collect { |node| node[:name] }}
        # Handle ansible verbosity level
        ansible.verbose =
          case ENV['VAGRANT_LOG']
            when 'debug' then 'vvvv'
            when 'info' then 'vvv'
            else 'v'
          end
      end

      # Customize VM settings
      node_config.vm.provider "virtualbox" do |vbox|
        # Set 1/2 of available CPU cores (one core on single-core machine)
        # and 1/4 of available system memory (1024 if system has less than 4Gb of RAM)
        set_vm_settings(vbox, 1, 1024)

        # This option makes the NAT engine use the host's resolver mechanisms to handle DNS requests
        vbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      end
    end
  end

  # Handle ansible galaxy roles
  if File.exist?("#{galaxy_roles_file}")
    config.vm.provision :host_shell do |host_shell|
      host_shell.inline = "ansible-galaxy install -r #{galaxy_roles_file} -p #{ansible_dir}/roles -f"
    end
  end

  # <editor-fold desc="Configure host manager" defaultstate="collapsed">
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  # Resolve VM IP to map host
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    if vm.id
      `VBoxManage guestproperty get #{vm.id} "/VirtualBox/GuestInfo/Net/1/V4/IP"`.split()[1]
    end
  end
  # </editor-fold>
end
