# Infraestructura como codigo y manifiestos de despliegue

Este documento complementa el README principal del proyecto y detalla el codigo
usado para crear la infraestructura en AWS y para desplegar la aplicacion sobre
ella, tal como lo requiere la pauta de la Evaluacion Final Transversal.

## Estructura agregada

```
infra/
  main.tf                    -> VPC, subredes publicas y privadas, security groups,
                                 RDS, ECR, cluster ECS, Application Load Balancer,
                                 Auto Scaling del servicio frontend
  variables.tf                -> variables de entrada (credenciales, CIDRs, etc.)
  outputs.tf                  -> IDs y ARNs generados (subredes, SGs, ALB, ECR, etc.)
  terraform.tfvars.example    -> plantilla de variables a completar

ecs/
  task-definitions/
    frontend-task.json
    ventas-task.json
    despachos-task.json
  services/
    frontend-service.json
    ventas-service.json
    despachos-service.json
  scripts/
    1-register-task-definitions.sh
    2-create-services.sh
    3-force-redeploy.sh
```

## 1. Infraestructura (Terraform)

El archivo `infra/main.tf` define, como codigo, toda la infraestructura de red y
soporte:

- Una VPC con **2 subredes publicas** (frontend, backends y el Load Balancer) y
  **2 subredes privadas** (base de datos), cada una correctamente etiquetada
  (`Tier = public` / `Tier = private`) y distribuida en dos zonas de disponibilidad.
- Un Internet Gateway y una tabla de rutas publica (0.0.0.0/0 -> IGW) asociada a
  las subredes publicas. Las subredes privadas no tienen ruta de salida a
  internet, ya que la base de datos no la necesita.
- Cuatro Security Groups en cadena: `alb-sg` (publico, puerto 80) ->
  `frontend-sg` (solo desde el ALB) -> `backend-sg` (solo desde el frontend) ->
  `db-sg` (solo desde los backends).
- Una instancia Amazon RDS MySQL desplegada en las subredes privadas.
- Los 3 repositorios de Amazon ECR (frontend, ventas-backend, despachos-backend).
- El cluster de Amazon ECS (Fargate).
- Un **Application Load Balancer** publico que expone el servicio de frontend
  como unico punto de entrada a internet (reemplaza el uso de la IP publica
  directa de una tarea, que no es estable ni corresponde a un entorno
  productivo).
- Una politica de Auto Scaling (equivalente a un HPA de Kubernetes) para el
  servicio de frontend, basada en el uso de CPU.

### Como ejecutarlo

```bash
cd infra
cp terraform.tfvars.example terraform.tfvars
# completar terraform.tfvars con las credenciales del AWS Details de AWS Academy
# y el ARN de LabRole (IAM -> Roles -> LabRole -> ARN)

terraform init
terraform plan
terraform apply
```

Nota importante sobre el entorno academico: AWS Academy Learner Lab no permite
crear roles ni politicas IAM nuevas (el rol `LabRole` ya existe y se reutiliza
como rol de ejecucion y de tarea para ECS). Las credenciales entregadas por el
laboratorio son temporales (incluyen `session_token`) y deben renovarse cada
vez que se reinicia la sesion del lab.

## 2. Manifiestos de despliegue (ECS)

A diferencia del entorno de desarrollo local (que usa `docker-compose.yml`,
excluido intencionalmente de esta carpeta), el despliegue en la nube se
realiza mediante manifiestos nativos de ECS:

- **Task definitions** (`ecs/task-definitions/*.json`): definen la imagen,
  puertos, variables de entorno y configuracion de logs de cada contenedor.
- **Services** (`ecs/services/*.json`): definen cuantas tareas deben mantenerse
  corriendo, en que subredes, con que Security Group, y en el caso del
  frontend, su registro en el Target Group del Load Balancer.

### Como desplegar

1. Reemplazar los placeholders (`<AWS_ACCOUNT_ID>`, `<RDS_ENDPOINT>`,
   `<PUBLIC_SUBNET_ID_1>`, `<FRONTEND_SG_ID>`, etc.) en los archivos JSON con
   los valores reales obtenidos de `terraform output` tras aplicar la
   infraestructura.
2. Ejecutar en orden:

```bash
bash ecs/scripts/1-register-task-definitions.sh
bash ecs/scripts/2-create-services.sh
```

3. Para desplegar una nueva version de imagen tras un cambio de codigo:

```bash
bash ecs/scripts/3-force-redeploy.sh
```

## 3. Limitaciones conocidas del entorno academico

- Las credenciales de la base de datos se gestionan como variables de entorno
  en texto plano en las task definitions, en lugar de referencias a AWS
  Secrets Manager (`valueFrom`), porque el rol `LabRole` no cuenta con el
  permiso `secretsmanager:GetSecretValue`. En un entorno productivo sin esta
  restriccion, se recomienda usar Secrets Manager con un rol de minimo
  privilegio dedicado.
- La comunicacion interna entre el frontend y los backends no usa ECS Service
  Connect (requiere el permiso `servicediscovery:CreateHttpNamespace`, no
  disponible en `LabRole`); en su lugar, el frontend enruta las peticiones
  usando las direcciones IP privadas asignadas por Fargate a cada tarea.
- Debido a que ambos backends no cuentan con NAT Gateway ni acceso a internet
  desde una subred privada (para reducir costos del laboratorio), estos se
  desplegaron en las subredes publicas, restringiendo el acceso mediante
  Security Groups en cadena. Unicamente la base de datos se ubica en las
  subredes privadas.
