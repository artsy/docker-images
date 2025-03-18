project := pg-data-sync
image_tag ?= 14.12

help:
	@echo 'Commands:'
	@echo '	publish-ecr:		Build an image and push to ECR'
	@echo '	publish-hub:		Build an image and push to DockerHub'
get-registry:
	$(eval ecr_registry=$(shell aws ecr describe-registry | jq '.registryId').dkr.ecr.us-east-1.amazonaws.com)
publish-ecr: get-registry
	aws ecr get-login-password --region us-east-1 | \
	docker login --username AWS --password-stdin $(ecr_registry) && \
	docker build --platform=linux/amd64 -t $(project):$(image_tag) . && \
	docker tag $(project):$(image_tag) $(ecr_registry)/$(project):$(image_tag)
	docker push $(ecr_registry)/$(project):$(image_tag)
publish-hub:
	docker build --platform=linux/amd64 -t artsy/$(project) . && \
	docker tag artsy/$(project):latest artsy/$(project):$(image_tag)
	docker push artsy/$(project):$(image_tag)
