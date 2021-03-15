FROM adoptopenjdk/openjdk8:alpine
RUN addgroup -S spring \
    && adduser -S spring -G spring \
    && mkdir -p /app
USER spring:spring
WORKDIR /app

EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app/*.jar"]

