FROM openjdk:8-jdk-alpine

ENV PORT=8080

COPY ./target/ /var/www

WORKDIR /var/www

EXPOSE $PORT

ENTRYPOINT ["java","-jar","demo-producer-0.0.1-SNAPSHOT.jar"]
