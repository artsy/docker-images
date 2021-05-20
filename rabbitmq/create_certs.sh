#! /bin/bash

mkdir ssl && cd ssl
mkdir certs private
chmod 700 private
echo 01 > serial
touch index.txt
openssl req -x509 -config openssl.cnf -newkey rsa:2048 -days 3650 -out cacert.pem -outform PEM -subj /CN=ArtsyCA/ -nodes
cd ../
mkdir server
cd server
openssl genrsa -out key.pem 2048
openssl req -new -key key.pem -out req.pem -outform PEM -subj /CN=*.artsy.net/O=server/ -nodes
cd ../artsyca
openssl ca -config openssl.cnf -in ../server/req.pem -out ../server/cert.pem -notext -batch -extensions server_ca_extensions
cd ../
mkdir client
cd client
openssl genrsa -out key.pem 2048
openssl req -new -key key.pem -out req.pem -outform PEM -subj /CN=*.artsy.net/O=client/ -nodes
cd ../artsyca
openssl ca -config openssl.cnf -in ../client/req.pem -out ../client/cert.pem -notext -batch -extensions client_ca_extensions
