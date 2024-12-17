# The Proxmox homelab setup example

This is a simple infrastructure repository that demonstrate how to setup Proxmox based servers in homelab.

The purpose of this repository is to demonstrate basic Ansible and Terraform concepts. Network settings, storage and some other configurations are outside the scope of this purpose.

✅ Successfully tested on bare metal.

## What has been implemented

- [x] Initial node setup

1. add new sudo user with some settings;
2. configure access via ssh;
3. restrict root access;

- [x] Node management

1. packages updater;
2. ssh-key changer;

- [ ] LXC setup (in progress)
