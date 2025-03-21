#Пользователь разработчик, который может только просматривать ресурсы кластера
openssl genrsa -out developer.key 2048
openssl req -new -key developer.key -out developer.csr -subj "/CN=developer/O=group2"
openssl x509 -req -in developer.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out developer.crt -days 365
kubectl config set-credentials developer --client-certificate=developer.crt --client-key=developer.key
kubectl config set-context developer-context --cluster=minikube --user=developer

#Пользователь девопс, который может настраивать кластер
openssl genrsa -out devops.key 2048
openssl req -new -key devops.key -out devops.csr -subj "/CN=devops/O=group1"
openssl x509 -req -in devops.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out devops.crt -days 365
kubectl config set-credentials devops --client-certificate=devops.crt --client-key=devops.key
kubectl config set-context devops-context --cluster=minikube --user=devops

#Пользователь специалист по ИБ, который может просматривать секреты
openssl genrsa -out security.key 2048
openssl req -new -key security.key -out security.csr -subj "/CN=security/O=group1"
openssl x509 -req -in security.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out security.crt -days 365
kubectl config set-credentials security --client-certificate=security.crt --client-key=security.key
kubectl config set-context security-context --cluster=minikube --user=security