.PHONY: image run interactive clean purge 
VERSION = 0.0.1
IMAGE_NAME = jeffre/chromecastwebapp
LABEL = com.jeffre.chromecastwebapp

image:
	docker build --progress plain \
	    -t $(IMAGE_NAME):$(VERSION) \
	    -t $(IMAGE_NAME):latest \
	    .

run:
	docker run --rm -it \
	  -p 80:8080 \
	  $(IMAGE_NAME):$(VERSION)

interactive:
	docker run --rm -it \
	  -p 127.0.0.1:80:80 \
	  $(IMAGE_NAME):$(VERSION) bash

clean:
	-find . -iname .DS_Store -delete

purge:
	-docker kill $(docker ps --filter="label=$(LABEL)" -q)
	-docker rm -f $(docker ps --filter="label=$(LABEL)" -q)
	-docker rmi $(docker images --filter="label=$(LABEL)" -q)
