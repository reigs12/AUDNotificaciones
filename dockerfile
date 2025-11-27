# ---- Etapa 1: Construcción con Maven ----
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copiar archivos del proyecto
COPY pom.xml .
COPY src ./src

# Construir sin correr tests
RUN mvn clean package -DskipTests


# ---- Etapa 2: Imagen liviana para ejecutar Spring Boot ----
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copiar el jar generado desde la etapa anterior
COPY --from=build /app/target/*.jar app.jar

# Render asigna el puerto mediante la variable PORT
ENV PORT=8080

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]