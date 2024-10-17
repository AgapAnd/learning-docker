FROM maven:3.8.6-eclipse-temurin-19 as maven-builder
COPY src /app/src
COPY pom.xml /app

WORKDIR /app

RUN mvn -f pom.xml clean package


FROM eclipse-temurin:19_36-jdk-alpine
COPY --from=maven-builder app/target/hello-app-1.0-SNAPSHOT.jar /target/hello-app.jar

WORKDIR /target

ENTRYPOINT ["java","-jar","hello-app.jar"]