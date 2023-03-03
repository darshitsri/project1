FROM lolhens/baseimage-openjre
ADD /home/runner/work/project1/project1/target/springbootApp.jar springbootApp.jar
EXPOSE 80
ENTRYPOINT ["java", "-jar", "springbootApp.jar"]
