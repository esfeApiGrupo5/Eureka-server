# Usa una imagen base de OpenJDK 21
FROM openjdk:21-jdk-slim

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo JAR de la aplicación al contenedor
COPY target/eurekaServer-0.0.1-SNAPSHOT.jar eurekaServer.jar

# Expone el puerto que usa la aplicación
EXPOSE 8761

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "eurekaServer.jar"]