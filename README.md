# Dell C6100 Scripts

The project includes scripts useful for managing Dell C6100 servers.

## remote-control.sh 

This command performs remote power management operations using the KVM over IP port.

__Usage__
```
$ ./remote-control.sh  
Usage: <Mangagement IP Addres> <Remote Command>
  <Management IP Address>
  <Remote Command> - [on|off|reboot]
```

__Example__
```
$ ./remote-control.sh 192.168.5.101 off
Powering off node: 192.168.5.101
```
