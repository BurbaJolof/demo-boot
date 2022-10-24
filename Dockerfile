FROM openjdk:11.0.16-jre

COPY target/demo-boot-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]

