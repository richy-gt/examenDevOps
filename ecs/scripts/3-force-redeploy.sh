#!/bin/bash
# Fuerza un nuevo despliegue de los 3 servicios ECS (util tras publicar
# nuevas imagenes en ECR con el tag 'latest').

set -e

CLUSTER="examendevops-cluster"

for SERVICE in frontend-service ventas-service despachos-service; do
  echo "Forzando nuevo despliegue de $SERVICE..."
  aws ecs update-service --cluster "$CLUSTER" --service "$SERVICE" --force-new-deployment
done

echo "Despliegue forzado en los 3 servicios."
