#!/bin/bash
# Crea los 3 servicios ECS a partir de los manifiestos JSON.
# Requiere que las task definitions ya esten registradas (paso 1) y que
# los placeholders de ecs/services/*.json hayan sido reemplazados con los
# IDs reales de subredes, security groups y el ARN del target group (salidas
# de 'terraform output' en infra/).

set -e

echo "Creando frontend-service..."
aws ecs create-service --cli-input-json file://ecs/services/frontend-service.json

echo "Creando ventas-service..."
aws ecs create-service --cli-input-json file://ecs/services/ventas-service.json

echo "Creando despachos-service..."
aws ecs create-service --cli-input-json file://ecs/services/despachos-service.json

echo "Servicios creados. Verifica el estado con:"
echo "aws ecs describe-services --cluster examendevops-cluster --services frontend-service ventas-service despachos-service"
