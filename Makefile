.phony: docker.build docker.run docker.push deployment.kustomize deployment.deploy

docker.build:
	docker build -t ${NJAPWI_DOCKER_IMAGE_NAME} app

docker.run:
	docker run \
	-v ${GOOGLE_APPLICATION_CREDENTIALS}:/secrets/credentials.json \
	-e GOOGLE_APPLICATION_CREDENTIALS=/secrets/credentials.json \
	-e NJAPWI_DOCKER_IMAGE_NAME \
	-e NJAPWI_K8S_NAMESPACE \
	-e NJAPWI_GCP_BUCKET \
	-e NJAPWI_SECRET_VERSION_NAME \
	--rm ${NJAPWI_DOCKER_IMAGE_NAME}

docker.push:
	docker push ${NJAPWI_DOCKER_IMAGE_NAME}:latest

deployment.kustomize:
	kubectl kustomize deployment/base | envsubst 

deployment.deploy:
	kubectl kustomize deployment/base | envsubst | kubectl apply -f -
