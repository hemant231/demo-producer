
FROM java:8
MAINTAINER Example Pablo Ezequiel

# Update the repository sources list
RUN apt-get update

################## BEGIN INSTALLATION ######################
# Install MongoDB Following the Instructions at MongoDB Docs
# Ref: http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

# Add the package verification key
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

# Add MongoDB to the repository sources list
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list

# Update the repository sources list once more
RUN apt-get update

# Install MongoDB package (.deb)
RUN apt-get install -y mongodb-10gen

# Create the default data directory
RUN mkdir -p /data/db

EXPOSE 8081

ADD target/demo-producer-0.0.1-SNAPSHOT.jar demo-producer-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java","-jar","demo-producer-0.0.1-SNAPSHOT.jar","--server.port=8081"] 
