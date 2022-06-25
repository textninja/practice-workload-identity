.phony: deployed docker.image docker.push

docker.build:
	docker build -t ${DOCKER_IMAGE_NAME} app

docker.run:
	docker run --rm ${DOCKER_IMAGE_NAME}

docker.push:
	docker push ${DOCKER_IMAGE_NAME}:latest

app.deploy:
	kubectl kustomize deployment/base | envsubst | kubectl apply -f -
