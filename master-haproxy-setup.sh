#!/bin/bash






# Run these commands on the Haproxy server


#install mysql first
sudo apt-get install mysql-client


#then Haproxy itself
sudo apt-get install haproxy


# Enable HAProxy to be started by the init script.
sudo sed -i "s/ENABLED=0/ENABLED=1/" /etc/default/haproxy

if [ ! -f /etc/haproxy/haproxy.cfg ]; then

  # Install haproxy
  /usr/bin/apt-get -y install haproxy

  # Configure haproxy
  cat > /etc/default/haproxy <<EOD
# Set ENABLED to 1 if you want the init script to start haproxy.
ENABLED=1

EOD
  cat > /etc/haproxy/haproxy.cfg <<EOD
global
    log 127.0.0.1 local0 notice
    user haproxy
    group haproxy

defaults
    log global
    retries 2
    timeout connect 3000
    timeout server 5000
    timeout client 500

listen mysql-cluster
    bind 127.0.0.1:3306
    mode tcp
    option mysql-check user haproxy_check
    balance roundrobin
    server master 54.237.144.8:3306 check
    server mysql-2 54.205.148.246:3306 check
    server mysql-1 54.237.142.9:3306 check

listen stat
    bind 0.0.0.0:8080
    mode http
    stats enable
    stats uri /
    stats realm Strictly\ Private
EOD

  cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.orig
  /usr/sbin/service haproxy restart
fi


#########################################################################################################
#                                                                                                       #
#                                                                                                       #
#                    Note this test approach setup Haproxy on the master DB                             #
#                                                                                                       #
#                                                                                                       #
#                                                                                                       #
#########################################################################################################       