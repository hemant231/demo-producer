FROM openjdk:8-jdk-alpine

ENV PORT=8080

COPY ./target/ /var/www

WORKDIR /var/www

EXPOSE $PORT

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","yello-ms-0.0.1-SNAPSHOT.jar"]
