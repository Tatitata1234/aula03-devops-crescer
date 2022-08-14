FROM maven:3.6.0-jdk-11-slim AS build
WORKDIR /app
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package
ARG PORT=9320

FROM openjdk:11-jre-slim
COPY --from=build app/target/hellodocker-0.0.1-SNAPSHOT.jar /app/hellodocker-0.0.1.jar
EXPOSE 8080
ENTRYPOINT [ "java","-Dserver.port=$PORT","-jar","/app/hellodocker-0.0.1.jar" ]
