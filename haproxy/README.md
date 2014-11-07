HAProxy Cluster Formula
=======================

This Saltstack formula installs and configures a highly available HAProxy Cluster. The HAProxy cluster requires
two nodes.

Example top.sls:
```
base:
  '*lb*':
    - haproxy_cluster
```

The formula can be configured using the `salt` command.

```
salt '*lb*' state.sls haproxy_cluster pillar="{'vip': '192.168.1.10', 'vip_int': 'bond0'}"
```

If you do not specify an interface, eth0 is used as the default.

``Testing Failover``
====================
When you have configured your HAProxy cluster pair, you can verify the floating IP address using the
following command:-

```
$ ip addr | grep -i [INTERFACE]
```

On the active node, you can issue a `service iptables panic`, which will cause communication to fail
and the IP address will move over the the standby HAProxy. To fail back, just issue the 
`service iptables restart` command.
