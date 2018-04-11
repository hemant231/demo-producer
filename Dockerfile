FROM ubuntu:14.04

COPY ./go-ecs-ecr /opt/
EXPOSE 8080

ENTRYPOINT ["/opt/go-ecs-ecr"]
