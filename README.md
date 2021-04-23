# Golang-Boilerplate

### initial setup

#### migrate cli install

```
curl -L https://github.com/golang-migrate/migrate/releases/download/$version/migrate.$platform-amd64.tar.gz | tar xvz \
&& mv migrate /usr/local/bin

```

#### swag cli install

using prebuilt binaries

```
1. go to https://github.com/swaggo/swag/releases and find a version that match your environment.
2. download
3. extract and move binary file to /usr/local/bin
```

alternative

```
go get -u github.com/swaggo/swag/cmd/swag
```

#### gosec cli install

```
# binary will be $(go env GOPATH)/bin/gosec
curl -sfL https://raw.githubusercontent.com/securego/gosec/master/install.sh | sh -s -- -b $(go env GOPATH)/bin latest
```

### migrations:

```bash
make migration.up user=<db_user> pass=<db_pass> host=<db_host> table=<db_table>
```

- Rename `.env.example` to `.env` and fill it with your environment values.

- Run project by this command:

```bash
make run
```

-. Go to API Docs page (Swagger): [localhost:5000/swagger/index.html](http://localhost:5000/swagger/index.html).

### 📦 Used packages

| Name                                                                  | Version   | Type       |
| --------------------------------------------------------------------- | --------- | ---------- |
| [gofiber/fiber](https://github.com/gofiber/fiber)                     | `v2.5.0`  | core       |
| [gofiber/jwt](https://github.com/gofiber/jwt)                         | `v2.1.0`  | middleware |
| [arsmn/fiber-swagger](https://github.com/arsmn/fiber-swagger)         | `v2.3.0`  | middleware |
| [stretchr/testify](https://github.com/stretchr/testify)               | `v1.7.0`  | tests      |
| [dgrijalva/jwt-go](https://github.com/dgrijalva/jwt-go)               | `v3.2.0`  | auth       |
| [joho/godotenv](https://github.com/joho/godotenv)                     | `v1.3.0`  | config     |
| [jmoiron/sqlx](https://github.com/jmoiron/sqlx)                       | `v1.3.1`  | database   |
| [jackc/pgx](https://github.com/jackc/pgx)                             | `v4.10.1` | database   |
| [swaggo/swag](https://github.com/swaggo/swag)                         | `v1.7.0`  | utils      |
| [google/uuid](https://github.com/google/uuid)                         | `v1.2.0`  | utils      |
| [go-playground/validator](https://github.com/go-playground/validator) | `v10.4.1` | utils      |

## 🗄 Template structure

### ./cmd

**Folder with business logic only**. This directory doesn't care about _what database driver you're using_ or _which caching solution your choose_ or any third-party things.

- `./cmd/controllers` folder for functional controllers (used in routes)
- `./cmd/models` folder for describe business models and methods of your project
- `./cmd/queries` folder for describe queries for models of your project
- `./cmd/validators` folder for describe validators for models fields

### ./docs

**Folder with API Documentation**. This directory contains config files for auto-generated API Docs by Swagger.

### ./pkg

**Folder with project-specific functionality**. This directory contains all the project-specific code tailored only for your business use case, like _configs_, _middleware_, _routes_ or _utils_.

- `./pkg/configs` folder for configuration functions
- `./pkg/middleware` folder for add middleware (Fiber built-in and yours)
- `./pkg/routes` folder for describe routes of your project
- `./pkg/utils` folder with utility functions (server starter, error checker, etc)

### ./platform

**Folder with platform-level logic**. This directory contains all the platform-level logic that will build up the actual project, like _setting up the database_ or _cache server instance_ and _storing migrations_.

- `./platform/database` folder with database setup functions (by default, PostgreSQL)
- `./platform/migrations` folder with migration files (used with [golang-migrate/migrate](https://github.com/golang-migrate/migrate) tool)

## ⚙️ Configuration

```ini
# .env

# Server settings:
SERVER_URL="0.0.0.0:5000"
SERVER_EMAIL="no-reply@example.com"
SERVER_EMAIL_PASSWORD="secret"

# JWT settings:
JWT_SECRET_KEY="secret"
JWT_REFRESH_KEY="refresh"

# Database settings:
DB_SERVER_URL="host=localhost port=5432 user=postgres password=password dbname=postgres sslmode=disable"
DB_MAX_CONNECTIONS=100
DB_MAX_IDLE_CONNECTIONS=10
DB_MAX_LIFETIME_CONNECTIONS=2

# SMTP severs settings:
SMTP_SERVER="smtp.example.com"
SMTP_PORT=25
```
