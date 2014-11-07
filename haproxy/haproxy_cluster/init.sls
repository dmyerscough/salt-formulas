
include:
  - haproxy_cluster.packages

# Allow additional IP addresses to bind to interfaces
# without being defined in the interface file
ip_nonlocal_bind:
  sysctl.present:
    - name: net.ipv4.ip_nonlocal_bind
    - value: 1

keepalived.conf:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://haproxy_cluster/configs/keepalived/keepalived.conf
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - require:
      - sls: haproxy_cluster.packages

keepalived:
  service.running:
    - enable: True
    - watch:
      - file: /etc/keepalived/keepalived.conf

haproxy.cfg:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://haproxy_cluster/configs/haproxy/haproxy.cfg
    - user: haproxy
    - group: haproxy
    - mode: 755
    - template: jinja
    - require:
      - sls: haproxy_cluster.packages

haproxy:
  service.running:
    - enable: True
    - watch:
      - file: /etc/haproxy/haproxy.cfg
