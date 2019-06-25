
sudo mysql -u root -p -e "INSERT INTO mysql.user (Host,User, ssl_cipher,x509_issuer,x509_subject) values ('IP of Haproxy server','haproxy_check','','',''); FLUSH PRIVILEGES;"

sudo mysql -u root -p -e "GRANT ALL PRIVILEGES ON *.* TO 'haproxy_root'@'IP of Haproxy server' IDENTIFIED BY 'whatever username you choose' WITH GRANT OPTION; FLUSH PRIVILEGES"