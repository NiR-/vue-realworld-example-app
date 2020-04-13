.PHONY: build
build:
	docker buildx build --load -t vue-example-app -f zbuild.yml --target dev .

.PHONY: install-deps
install-deps:
	docker run --rm -it -v $(PWD):/app -w /app vue-example-app yarn install
