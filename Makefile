IMGNAME := kanna5/httpbin

image:
	DOCKER_BUILDKIT=1 docker build --no-cache -t $(IMGNAME) .

push:
	docker push $(IMGNAME)

.PHONY: image push
