#!/bin/bash

set -e
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -u|--username)
    USERNAME="$2"
    shift # past argument
    shift # past value
    ;;
    -g|--group)
    USER_GROUP="$2"
    shift # past argument
    shift # past value
    ;;
    -ns|--namespace)
    NAMESPACE="$2"
    shift # past argument
    shift # past value
    ;;
    -crt|--cert-path)
    CERT_PATH="$2"
    shift # past argument
    shift # past value
    ;;
    -key|--key-path)
    KEY_PATH="$2"
    shift # past argument
    shift # past value
    ;;
    -name|--cluster-name)
    CLUSTER_NAME="$2"
    shift # past argument
    shift # past value
    ;;
    -api|--cluster-api)
    CLUSTER_API="$2"
    shift # past argument
    shift # past value
    ;;
    *)
    shift    # unknown option
    ;;
esac
done



openssl genrsa -out $USERNAME.key 2048
openssl req -new -key $USERNAME.key -out $USERNAME.csr -subj "/CN=$USERNAME/O=$USER_GROUP"
openssl x509 -req -in $USERNAME.csr -CA $CERT_PATH -CAkey $KEY_PATH -CAcreateserial -out $USERNAME.crt -days 500

echo -e "apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: $(cat ${CERT_PATH} | base64 -w0)
    server: ${CLUSTER_API}
  name: ${CLUSTER_NAME}
contexts:
- context:
    cluster: ${CLUSTER_NAME}
    namespace: $namespace
    user: $USERNAME
  name: $USERNAME-$CLUSTER_NAME
current-context: $USERNAME-$CLUSTER_NAME
kind: Config
preferences: {}
users:
- name: $USERNAME
  user:
    client-certificate-data: \"$(cat $USERNAME.crt | base64 -w0)\"
    client-key-data: \"$(cat $USERNAME.key | base64 -w0)\""


# rm -rf $USERNAME.*