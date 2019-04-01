# Fortune Infra repo

This repo contains ansible roles, playbooks, Kubernetes scripts and roles.

**IMPORTANT**: Before running check all roles variables, they are NOT filled.

# MongoDB

### Starting MongoDB from scratch


`ansible-playbook -i ec2.py production_fortune_mongodb.yml -u ubuntu --private-key=\<path-to-your-private-key> --ask-vault-pass`


# Monitoring

### Starting Monitoring from scratch

`ansible-playbook -i ec2.py production_fortune_infra.yml -u ubuntu --private-key=\<path-to-your-private-key> --ask-vault-pass`

### Update prometheus
`ansible-playbook -i ec2.py production_fortune_infra.yml  --tags setup-prometheus -u ubuntu --private-key=\<path-to-your-private-key> --ask-vault-pass`


### Restart prometheus
`ansible-playbook -i ec2.py production_fortune_infra.yml  --tags start-prometheus -u ubuntu --private-key=\<path-to-your-private-key> --ask-vault-pass`

### Update Grafana
`ansible-playbook -i ec2.py production_fortune_infra.yml  --tags start-grafana -u ubuntu --private-key=\<path-to-your-private-key> --ask-vault-pass`


### Set up users - this apply to all playbooks

`ansible-playbook -i ec2.py <your-playbook>.yml --tags users -u ubuntu --private-key=\<path-to-your-private-key> --ask-vault-pass`


### Set up Nginx proxy - this apply to all playboks

`ansible-playbook -i ec2.py <your-playbook>.yml --tags setup-proxy -u ubuntu --private-key=\<path-to-your-private-key> --ask-vault-pass`

### Set up Letsencrypt - this apply to all playbooks with the letsencrypt role

`ansible-playbook -i ec2.py <your-playbook>.yml --tags setup-letsencrypt -u ubuntu --private-key=\<path-to-your-private-key> --ask-vault-pass`

### Set up Node exporter - this apply to all playbooks with the prometheus

`ansible-playbook -i ec2.py <your-playbook>.yml --tags node-exporter -u ubuntu --private-key=\<path-to-your-private-key> --ask-vault-pass`

### Set up Mongo exporter - this apply to all playbooks with the prometheus

`ansible-playbook -i ec2.py <your-playbook>.yml --tags mongo-exporter -u ubuntu --private-key=\<path-to-your-private-key> --ask-vault-pass`

# Kubernetes

## Creating a kube config file for users

Setting the environments below is required

/k8s-new-user.sh --username travis --group CI --namespace default --cert-path k8s.crt --key-path 'k8s.key' --cluster-api https://api.k8s.mycluster.com --cluster-name k8s.mycluster.com

Copy the output to `~/.kube/config`


## Kubernetes Role examples


Role examples can be found [here](https://github.com/thiagotrennepohl/fortune-infra/tree/master/kubernetes/roles)
    
