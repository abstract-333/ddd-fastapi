DC = docker compose
EXEC = docker exec -t
LOGS = docker logs
ENV = --env-file .env
APP_FILE = docker_compose/app.yaml
APP_CONTAINER = main-app

.PHONY: app
app:
	${DC} -f ${APP_FILE} ${ENV} up --build -d

.PHONY: app-down
app-down:
	${DC} -f ${APP_FILE} down

.PHONY: app-logs
app-logs:
	${LOGS} ${APP_CONTAINER} -f

.PHONY: app-shell
app-shell:
	${EXEC} ${APP_CONTAINER} bash

.PHONY: format
format:
	${EXEC} ${APP_CONTAINER} black .
	${EXEC} ${APP_CONTAINER} isort .
	
.PHONY: test
test:
	${EXEC} ${APP_CONTAINER} pytest