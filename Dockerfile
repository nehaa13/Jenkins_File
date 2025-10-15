FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Use a lightweight JDK base image for the final image
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app
# Copy the built jar from the previous stage
COPY --from=build /app/target/*.jar app.jar
# Expose the application port (change if needed)
EXPOSE 8080
# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
