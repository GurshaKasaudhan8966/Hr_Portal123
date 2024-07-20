# Use maven to build the project
FROM maven:3.8.5-openjdk-17 AS build
COPY . /app
WORKDIR /app
RUN mvn clean package -DskipTests

# Use openjdk to run the application
FROM openjdk:17.0.1-jdk-slim
COPY --from=build /app/target/jwt-0.0.1-SNAPSHOT.jar HrPortal.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "HrPortal.jar"]
