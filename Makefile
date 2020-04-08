SHELL:=/bin/bash

help:
	@echo methods: build push run open logs images rm

run: rm
	docker run -d -p 3000:3000 --name dagster -v ${PWD}/dagster.yaml:/var/lib/data/dagster_home/dagster.yaml  -v ${PWD}/app:/app  pmoranga/dagster:last-build

rm:
	docker rm -f dagster || exit 0

logs:
	docker logs dagster

open:
	open http://localhost:3000

build:
	echo LINE >> ./docker-build-count.dat ; \
		docker build -t pmoranga/dagster:v0.$$(wc -l < ./docker-build-count.dat | tr -d ' ') -t pmoranga/dagster:last-build .

images:
	docker images | grep dagster

push:
	docker push pmoranga/dagster:last-build
	docker push pmoranga/dagster:v0.$$(wc -l < ./docker-build-count.dat | tr -d ' ')
	