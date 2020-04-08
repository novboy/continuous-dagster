# Dagster Image

The way to build it (it will automatically tag the image as dagster:last-build and dagster:v0.COUNT):

    make build

The way to run it:

	docker run -d -p 3000:3000 --name dagster -v ${PWD}/app/dagster.yaml:/var/lib/data/dagster_home/dagster.yaml -v ${PWD}/app:/app  dagster:last-build

*Note*: You can run this on this same repository or in any other repository containing both structures `./app/dagster.yaml` and `./app/`