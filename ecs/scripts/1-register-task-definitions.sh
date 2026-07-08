#!/bin/bash
# Registra las 3 task definitions en ECS a partir de los manifiestos JSON.
# Requiere reemplazar antes los placeholders <AWS_ACCOUNT_ID>, <RDS_ENDPOINT>,
# <DB_USERNAME> y <DB_PASSWORD> en los archivos de ecs/task-definitions/.

set -e

echo "Registrando frontend-task..."
aws ecs register-task-definition --cli-input-json file://ecs/task-definitions/frontend-task.json

echo "Registrando ventas-task..."
aws ecs register-task-definition --cli-input-json file://ecs/task-definitions/ventas-task.json

echo "Registrando despachos-task..."
aws ecs register-task-definition --cli-input-json file://ecs/task-definitions/despachos-task.json

echo "Task definitions registradas correctamente."
