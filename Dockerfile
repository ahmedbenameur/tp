# Stage 1: Build with Maven
FROM maven:3.9.9-eclipse-temurin-11 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Stage 2: Run app
FROM eclipse-temurin:11-jdk-jammy

WORKDIR /app

# copy generated jar
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
