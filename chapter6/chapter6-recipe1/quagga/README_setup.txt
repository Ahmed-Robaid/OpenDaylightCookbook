Quagga is an open source project for Network routing software that includes BGP implementation among many other routing protocols. The recipes in Chapter 6 use Quagga software suite to run BGP peer router and to establish a BGP connection between the Opendaylight and Quagga router. In order to achieve this Quagga needs to be configured for BGP as follows.

Prerequisite
-------------
Any Linux perating system can be used. Use the default package manager supported on the operating system in your setup for the following steps.
Ubuntu 14.04 has been used as an example for the recipe.

Installing Quagga router
------------------------
Use apt-get to install quagga:
sudo apt-get install quagga

Configuring Quagga router
-------------------------
Add the parameters to the file /etc/quagga/daemons:
zebra=yes 
bgpd = yes

Create a baseline bgpd configuration file /etc/quagga/bgpd.conf with the below contents:
root@quagga_vm:~# cat /etc/quagga/bgpd.conf 
hostname <name_of_the_bgp_peer>
password <password>
enable password <re-enter_password>

log timestamp precision 6
log file /var/log/quagga/bgpd.log
!
line vty
 exec-timeout 0 0
!

Restart quagga service:
root@quagga_vm:~# service quagga restart
root@quagga_vm:~# service quagga status
bgpd watchquagga

Configure the BGP peer settings:
root@quagga_vm:~# vtysh

Hello, this is Quagga (version 0.99.22.4).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

quagga_vm# write terminal
Building configuration...

Current configuration:
!
end
quagga_vm#
quagga_vm#
quagga_vm# write terminal
Building configuration...

Current configuration:
!
end
quagga_vm#

Enter the configure terminal:
quagga_vm# configure terminal

Set the AS number:
quagga_vm(config)# router bgp 65504

BGP router id configuration, here the router id 192.168.1.119 is used as an example:
quagga_vm(config-router)# bgp router-id 192.168.1.119

The neighbor is configured to Opendaylight BGP peer IP which is 192.168.1.102 is our setup. Add the neighbor to the same AS:
quagga_vm(config-router)# neighbor 192.168.1.102 remote-as 65504
quagga_vm(config-router)# address-family ipv4 unicast
quagga_vm(config-router-af)# neighbor 192.168.1.102 activate
quagga_vm(config-router-af)# exit
quagga_vm(config-router)# neighbor 192.168.1.102 route-reflector-client
quagga_vm(config-router)# address-family ipv4 unicast
quagga_vm(config-router-af)#  network 192.0.2.0/24
quagga_vm(config-router-af)# exit
quagga_vm(config-router)#exit
quagga_vm(config)# exit

Verify the configuration using the command below:
quagga_vm# write terminal
Building configuration...

Current configuration:
!
end
hostname R1
log file /var/log/quagga/bgpd.log
log timestamp precision 6
!
password admin
enable password admin
!
router bgp 65504
 bgp router-id 192.168.1.119
 network 192.0.2.0/24
 neighbor 192.168.1.102 remote-as 65504
 neighbor 192.168.1.102 route-reflector-client
!
line vty
 exec-timeout 0 0
!
