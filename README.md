# Evaluacion Transversal DevOps

## Descripcion general
Este proyecto corresponde a una evaluacion transversal de DevOps y desarrollo full stack. Implementa una solucion para la gestion de ventas y despachos, compuesta por un frontend en React, dos servicios backend en Spring Boot y una base de datos MySQL.

## Objetivo
Demostrar la integracion entre frontend, backend, base de datos y contenedores, utilizando buenas practicas de desarrollo y despliegue con Docker.

## Funcionalidades principales
- Gestion de ventas desde el servicio backend de ventas.
- Gestion de despachos desde el servicio backend de despachos.
- Interfaz web para visualizar y administrar la informacion.
- Documentacion de APIs con Swagger UI.
- Ejecucion del sistema mediante Docker Compose.

## Tecnologias utilizadas
- Frontend: React, Vite, Tailwind CSS, React Router, Axios
- Backend: Java 17, Spring Boot, Spring Data JPA, Validation
- Base de datos: MySQL 8
- DevOps: Docker, Docker Compose, Nginx

## Estructura del proyecto
- front-despacho: aplicacion web frontend
- back-ventas-springboot/api-rest-ventas: API para la gestion de ventas
- back-bespachos-springboot/api-rest-despacho: API para la gestion de despachos
- db-init: scripts de inicializacion de la base de datos
- docker-compose.yml: configuracion de los servicios del proyecto

## Requisitos previos
- Docker y Docker Compose instalados
- Java 17 y Maven (opcional para ejecucion local)
- Node.js y npm (opcional para desarrollo frontend)

## Ejecucion con Docker Compose
1. Clona el repositorio.
2. Desde la raiz del proyecto, ejecuta:
   ```bash
   docker compose up --build
   ```
3. Una vez levantados los servicios, puedes acceder a:
   - Frontend: http://localhost/
   - API Ventas: http://localhost:8080
   - API Despachos: http://localhost:8081
   - Swagger Ventas: http://localhost:8080/swagger-ui/index.html
   - Swagger Despachos: http://localhost:8081/swagger-ui/index.html

## Ejecucion local (opcional)
### Frontend
```bash
cd front-despacho
npm install
npm run dev
```

### Backend Ventas
```bash
cd back-ventas-springboot/api-rest-ventas
./mvnw spring-boot:run
```

### Backend Despachos
```bash
cd back-bespachos-springboot/api-rest-despacho
./mvnw spring-boot:run
```

## Variables de entorno
El archivo docker-compose.yml define las credenciales y parametros de conexion para la base de datos y los servicios backend.

## Notas adicionales
El proyecto incluye scripts de inicializacion para la base de datos y configuraciones listas para levantar el entorno completo de forma sencilla. 