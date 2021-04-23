.PHONY: clean test security build run

APP_NAME = apiserver
BUILD_DIR = $(PWD)/build
MIGRATIONS_FOLDER = $(PWD)/platform/migrations
DATABASE_URL = postgres://postgres:dev@localhost/dev-auth?sslmode=disable

clean:
	rm -rf ./build

security:
	gosec -quiet ./...

test: security
	go test -v -timeout 30s -coverprofile=cover.out -cover ./...
	go tool cover -func=cover.out

# # for production
# build: clean test
# 	CGO_ENABLED=0 go build -ldflags="-w -s" -o $(BUILD_DIR)/$(APP_NAME) main.go

# for dev
build: clean
	CGO_ENABLED=0 go build -ldflags="-w -s" -o $(BUILD_DIR)/$(APP_NAME) main.go

run: swag.init build
	$(BUILD_DIR)/$(APP_NAME)

migrate.up:
	migrate -path $(MIGRATIONS_FOLDER) -database "$(DATABASE_URL)" up

migrate.down:
	migrate -path $(MIGRATIONS_FOLDER) -database "$(DATABASE_URL)" down

migrate.force:
	migrate -path $(MIGRATIONS_FOLDER) -database "$(DATABASE_URL)" force $(version)

docker.run: docker.network docker.postgres swag.init docker.fiber docker.redis migrate.up

docker.network:
	docker network inspect dev-network >/dev/null 2>&1 || \
	docker network create -d bridge dev-network

docker.fiber.build:
	docker build -t fiber .

docker.fiber: docker.fiber.build
	docker run --rm -d \
		--name dev_smartproperty-auth_service \
		--network dev-network \
		-p 5000:5000 \
		fiber

docker.postgres:
	docker run --rm -d \
		--name dev-postgres \
		--network dev-network \
		-e POSTGRES_USER=postgres \
		-e POSTGRES_PASSWORD=password \
		-e POSTGRES_DB=postgres \
		-v ${HOME}/dev-postgres/data/:/var/lib/postgresql/data \
		-p 5432:5432 \
		postgres

docker.redis:
	docker run --rm -d \
		--name dev-redis \
		--network dev-network \
		-p 6379:6379 \
		redis

docker.stop: docker.stop.fiber docker.stop.postgres docker.stop.redis

docker.stop.fiber:
	docker stop dev_btn-app_auth-service

docker.stop.postgres:
	docker stop dev-postgres

docker.stop.redis:
	docker stop dev-redis

swag.init:
	swag init