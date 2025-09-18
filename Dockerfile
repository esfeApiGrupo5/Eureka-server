# Primera fase: Construcción
# Usa una imagen oficial de Maven que incluye Eclipse Temurin OpenJDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de Maven y el código fuente
COPY pom.xml .
COPY src ./src

# Compila el proyecto y genera el JAR
RUN --mount=type=cache,target=/root/.m2 mvn clean package -DskipTests

# Segunda fase: Ejecución
FROM openjdk:21-jdk-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia el JAR generado de la fase de construcción a la imagen final
COPY --from=build /app/target/eurekaServer-0.0.1-SNAPSHOT.jar eurekaServer.jar

# Expone el puerto de la aplicación
EXPOSE 8761

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "eurekaServer.jar"]