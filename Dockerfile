#
# Build stage
#
FROM maven:3.6.0-jdk-8-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM adoptopenjdk/openjdk8:alpine
WORKDIR /usr/local/lib
COPY --from=build /home/app/target/petclinic-1.0.jar ./petclinic-1.0.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","petclinic-1.0.jar"]
#CMD ["mvn", "spring-boot:run"]
