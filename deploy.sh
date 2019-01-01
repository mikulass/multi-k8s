docker build -t mikulass/multi-client:latest -t mikulass/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mikulass/multi-server:latest -t mikulass/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mikulass/multi-worker:latest -t mikulass/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mikulass/multi-client:latest
docker push mikulass/multi-server:latest
docker push mikulass/multi-worker:latest

docker push mikulass/multi-client:$SHA
docker push mikulass/multi-server:$SHA
docker push mikulass/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mikulass/multi-server:$SHA
kubectl set image deployments/client-deployment client=mikulass/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mikulass/multi-worker:$SHA
