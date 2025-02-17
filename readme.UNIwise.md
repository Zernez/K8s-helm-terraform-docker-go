# UNIwise devops assignment

## Description

This project containerized a GO web application that save messages statefully with subscribing to Redis topics. 
The `docker` folder is structured to have a docker images in `dev` environment that allows to debug the GO app inside the container in Visual Studio Code and a production `prod` environment used for production deployment of docker images. Similarly for `k8s` but in `dev` is not available the debugging inside the pods.
The structure is composed by the `goapp` container that contains the fullstack logic and `redis` that provide the service as sidecar.
All the project is conducted in a CI environment by Github Workflows that test, build push the docker images and in the end make a system test deploying the k8s
environment and curl the service adress.

## Requirements

- Docker
- Docker compose
- Kubernetes cluster
- GO (only for debugging)
- VSC (only for debugging)
- Helm
- AWS CLI
- Terraform

## Deploy

### Docker dev/debugging

1. Run the Docker container in `dev` folder: `docker compose up`

2. In VSC select `Go Conteinerized Debug` in `Run and Debug`

3. Access the application at `http://localhost:4444`

### Docker compose  

1. Run the Docker container in `prod` folder: `docker compose up`

2. Access the application at `http://localhost:5000`

### Kubernetes Deployment

1. Start the kubernetes cluster

2. Deploy the application: `kubectl apply -f k8s/prod`

3. Access the application at `http://localhost:30000`

### Helm/Kubernetes Deployment

1. Start the kubernetes cluster

2. In case of same namespace delete the resources with:  `kubectl delete -f k8s/prod`

3. Deploy the application: `helm install helm ./helm -f ./helm/values-prod.yaml`

4. Access the application at `http://localhost:30000`

5. `helm uninstall helm` for close

### Terraform Deployment (in development)

1. Set up AWS CLI with your credentials

2. Deploy the infrastructure by run from the folder `\terraform-provision-eks-cluster` the command `terraform init` and `terraform apply`

3. Deploy the helm charts by run from the folder `\terraform` the command `terraform init` and `terraform apply`

4. ...