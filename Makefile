.PHONY: build
build:
	docker build --platform linux/amd64,linux/arm64 -t dillonad/resumake.io:local .

.PHONY: run
run: build
	docker run -it --rm -p 3000:3000 dillonad/resumake.io:local