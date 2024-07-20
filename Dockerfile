# Stage 1: Build the application with Maven
FROM maven:latest AS build

# Install necessary packages
RUN apt-get update && apt-get install openjdk-17-jdk -y

# Copy the project files to the container
COPY . .

# Build the application using Gradle
RUN ./gradlew bootJar --no-daemon

# Verify the JAR file location
RUN ls -l /target/

# Stage 2: Create the final image
FROM openjdk:17-jdk-slim

# Expose the application port
EXPOSE 8080

# Copy the built JAR file from the build stage
COPY --from=build /target/jwt-0.0.1-SNAPSHOT.jar /app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]
