FROM adoptopenjdk/openjdk8:alpine
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
ARG APP_NAME=springboots-devops
ARG JAR_FILE=${APP_NAME}/*.jar
ADD $JAR_FILE /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]