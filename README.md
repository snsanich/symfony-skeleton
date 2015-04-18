General Backend Template Project
===================================

## Required software

 - VirtualBox
 - [Vagrant](https://www.vagrantup.com/)
 - [vagrant-host-shell](https://github.com/phinze/vagrant-host-shell) for auto install galaxy roles
 - [Vagrant Host Manager](https://github.com/smdahlen/vagrant-hostmanager) for handling local DNS and DHCP instead of static IP
 - [Ansible](http://docs.ansible.com/intro_installation.html)

### Vagrant and plugins

`vagrant-host-shell` will check that you have installed ansible galaxy roles before provisioning

*NOTE*: If galaxy roles list file not exists, this part will be skipped. Path to this file and directory with roles configurable in vagrantfile

```
ansible_dir = 'devops/ansible'
galaxy_roles_file = 'galaxy_roles.yml'
```

To make life less painful, we suggest to use DHCP instead of static IPs for private networking. In this case we don't know IP address of vagrant box before we log in into it. The solution is to use `vagrant-hostmanager`. It will check current box IP and add alias to `/etc/hosts` of your host and guest machine. Hostname of VM should be configured in `Vagrantfile`:

```
hostname = 'example.vagrant'
```

*NOTE*: Since this vagrantfile uses DHCP, plese checkout [this issue](https://github.com/mitchellh/vagrant/issues/3083) in Vagrant bug tracker. If your virtual machine is not starts, you can use workaround from this topic:

```
VBoxManage dhcpserver remove --netname HostInterfaceNetworking-vboxnet0
```
