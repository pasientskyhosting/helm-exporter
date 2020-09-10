VERSION ?= "1.0.0"
run:
	go run main.go

all: prep binaries docker

prep:
	mkdir -p bin

binaries: linux64 darwin64

linux64:
	GOOS=linux GOARCH=amd64 go build -o bin/helmexporter64 main.go

darwin64:
	GOOS=darwin GOARCH=amd64 go build -o bin/helmexporterOSX main.go

pack-linux64: linux64
	upx --brute bin/helmexporter64

pack-darwin64: darwin64
	upx --brute bin/helmexporterOSX

docker: pack-linux64
	docker build -t pasientskyhosting/helmexporter:$(VERSION) .

docker-run:
	docker run pasientskyhosting/helmexporter:$(VERSION)

docker-push: docker
	docker push pasientskyhosting/helmexporter:$(VERSION)