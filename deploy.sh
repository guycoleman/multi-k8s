#!/usr/bin/env bash

docker build -t guytcoleman/multi-client:latest -t guytcoleman/multi-client:$GIT_SHA ./client
docker build -t guytcoleman/multi-server:latest -t guytcoleman/multi-server:$GIT_SHA ./server
docker build -t guytcoleman/multi-worker:latest -t guytcoleman/multi-worker:$GIT_SHA ./worker

docker push guytcoleman/multi-client:latest
docker push guytcoleman/multi-server:latest
docker push guytcoleman/multi-worker:latest

docker push guytcoleman/multi-client:$GIT_SHA
docker push guytcoleman/multi-server:$GIT_SHA
docker push guytcoleman/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=guytcoleman/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=guytcoleman/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=guytcoleman/multi-worker:$GIT_SHA
