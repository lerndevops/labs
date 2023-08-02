#!/bin/bash 

which openssl
if [ $? -eq 0 ]; then
  echo "genereate self signend ca certificates.." 
  mkdir -p $HOME/ssl
  openssl genrsa -out $HOME/ssl/ca.key 2048
  openssl req -x509 -sha256 -new -nodes -key $HOME/ssl/ca.key -days 3650 -subj "/CN=demo-self-ca,/O=devops" -out $HOME/ssl/ca.crt
  echo "genereate self ca signed server certificates.."
  openssl genrsa -out $HOME/ssl/server.key 2048
  openssl req -new -key $HOME/ssl/server.key -out $HOME/ssl/server.csr -subj "/CN=server/O=devops"
  openssl x509 -req -in $HOME/ssl/server.csr -CA $HOME/ssl/ca.crt -CAkey $HOME/ssl/ca.key -CAcreateserial -out $HOME/ssl/server.crt -days 1000
  echo "certs are generated under $HOME/ssl folder & are ready to use now.. "
  ls -l $HOME/ssl
else
  echo "openssl is missing please install.." 
fi
