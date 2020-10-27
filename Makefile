$(eval REV=$(shell git rev-parse HEAD | cut -c1-7))

docker/login:
	$$(aws ecr get-login --no-include-email --region ap-northeast-2)

# Build docker target
docker/build:
	docker build -f ./Dockerfile -t moim-redash .	
	
# Tag docker image
docker/tag:	
	docker tag moim-redash:latest 921281748045.dkr.ecr.ap-northeast-2.amazonaws.com/moim-redash:latest
	docker tag moim-redash:latest 921281748045.dkr.ecr.ap-northeast-2.amazonaws.com/moim-redash:$(REV)	

# Push to registry
docker/push:	
	docker push 921281748045.dkr.ecr.ap-northeast-2.amazonaws.com/moim-redash:latest
	docker push 921281748045.dkr.ecr.ap-northeast-2.amazonaws.com/moim-redash:$(REV)	

# Build docker image and push to AWS registry
docker: docker/login docker/build docker/tag docker/push

