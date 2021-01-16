docker build -t themindset/multi-client:latest -f ./client/Dockerfile ./client
docker build -t themindset/multi-server:latest -f ./server/Dockerfile ./server
docker build -t themindset/multi-worker:latest -f ./worker/Dockerfile ./worker

docker build -t themindset/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t themindset/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t themindset/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push themindset/multi-client:latest
docker push themindset/multi-server:latest
docker push themindset/multi-worker:latest

docker push themindset/multi-client:$SHA
docker push themindset/multi-server:$SHA
docker push themindset/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=themindset/multi-server
kubectl set image deployments/client-deployment client=themindset/multi-client
kubectl set image deployments/worker-deployment worker=themindset/multi-worker
