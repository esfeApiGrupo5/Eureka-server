# Primera fase: construcción
FROM openjdk:21-jdk-slim AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de Maven y el código fuente
COPY pom.xml .
COPY src ./src

# Compila el proyecto y genera el JAR
RUN --mount=type=cache,target=/root/.m2 mvn clean package -DskipTests

# Segunda fase: ejecución
FROM openjdk:21-jdk-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia el JAR generado en la fase de construcción
COPY --from=build /app/target/eurekaServer-0.0.1-SNAPSHOT.jar eurekaServer.jar

# Expone el puerto
EXPOSE 8761

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "eurekaServer.jar"]