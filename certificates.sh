#private keys
openssl genrsa -out ca.key 2048
openssl genrsa -out admin.key 2048
openssl genrsa -out kube-scheduler.key 2048
openssl genrsa -out kube-controller-key.key 2048
openssl genrsa -out kube-proxy.key 2048
openssl genrsa -out kube-apiserver.key 2048
openssl genrsa -out etcd.key 2048
openssl genrsa -out service-account.key 2048


#csr requests grouped according to subject names.
# openssl req -new -key <>.key -subj "/CN=" -out <>.csr
openssl req -new -key ca.key -subj "/CN=KUBERNETES" -out ca.csr

openssl req -new -key admin.key -subj "/CN=admin/O=system:masters" -out admin.csr

openssl req -new -key kube-scheduler.key -subj "/CN=system:kube-scheduler" -out kube-scheduler.csr
openssl req -new -key kube-controller-manager.key -subj "/CN=system:kube-controller-manager" -out kube-controller-manager.csr
openssl req -new -key kube-proxy.key -subj "/CN=system:kube-proxy" -out kube-proxy.csr

openssl req -new -key kube-apiserver.key -subj "/CN=kube-apiserver" -out kube-apiserver.csr
openssl req -new -key etcd.key -subj "/CN=etcd-server" -out etcd.csr
openssl req -new -key service-account.key -subj "/CN=service-account" -out service-account.csr


#signing the csr to get the publickey
#openssl x509 -in <>.csr -CA <>.crt -CAkey <>.key -CAcreateserial -out <>.crt -days 1000
openssl x509 -req -in ca.csr -signkey ca.key -CAcreateserial  -out ca.crt -days 1000

openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out admin.crt -days 1000
openssl x509 -req -in kube-controller-manager.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out kube-controller-manager.crt -days 1000
openssl x509 -req -in kube-proxy.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-proxy.crt -days 1000
openssl x509 -req -in kube-scheduler.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-scheduler.crt -days 1000
openssl x509 -req -in service-account.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out service-account.crt -days 1000

openssl x509 -req -in kube-apiserver.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out kube-apiserver.crt -extensions v3_req -extfile openssl.cnf -days 1000
openssl x509 -req -in etcd-server.csr -CA ca.crt -CAkey ca.key -CAcreateserial  -out etcd-server.crt -extensions v3_req -extfile openssl-etcd.cnf -days 1000
