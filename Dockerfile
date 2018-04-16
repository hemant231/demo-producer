
FROM java:8

EXPOSE 8081

ADD target/demo-producer-0.0.1-SNAPSHOT.jar demo-producer-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java","-jar","demo-producer-0.0.1-SNAPSHOT.jar","--server.port=8081"] 
