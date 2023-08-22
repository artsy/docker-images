# Description: Makefile for building and pushing docker image to ECR for AWS Batch data-sync job
project := pg-data-sync
image_tag ?= 12

help:
	@echo 'Commands:'
	@echo '	push:			Build an image and push to ECR'
	@echo '	publish:		Build an image and push to DockerHub'
get-registry:
	$(eval ecr_registry=$(shell aws ecr describe-registry | jq '.registryId').dkr.ecr.us-east-1.amazonaws.com)
push: get-registry
	aws ecr get-login-password --region us-east-1 | \
	docker login --username AWS --password-stdin $(ecr_registry) && \
	docker build --platform=linux/amd64 -t $(project):$(image_tag) . && \
	docker tag $(project):$(image_tag) $(ecr_registry)/$(project):$(image_tag) \
	docker push $(ecr_registry)/$(project):$(image_tag)
publish:
	docker build --platform=linux/amd64 -t artsy/$(project) . \
	docker tag artsy/$(project):latest artsy/$(project):$(image_tag) \
	docker push artsy/$(project):$(image_tag)