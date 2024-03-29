# Use the official Gradle image to create a build artifact
FROM gradle:8.5-jdk21 as builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

# Use OpenJDK for running the application
FROM openjdk:21-oracle
EXPOSE 8080
COPY --from=builder /home/gradle/src/build/libs/*.jar /app/spring-boot-application.jar
ENTRYPOINT ["java", "-jar", "/app/spring-boot-application.jar"]
