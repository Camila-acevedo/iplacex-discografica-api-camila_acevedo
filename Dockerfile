# Stage 1: Build con Gradle
FROM gradle:8.5-jdk17 AS build
WORKDIR /app
COPY . .
RUN cd discografia && gradle bootJar --no-daemon

# Stage 2: Ejecución con Java 17
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/discografia/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]