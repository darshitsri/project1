FROM tomcat:9.0.48-jdk11-openjdk-slim
WORKDIR /usr/local/tomcat/webapps
COPY target/OnlineVotingSystemV3-1.0-SNAPSHOT.war .
