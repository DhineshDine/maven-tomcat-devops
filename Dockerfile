FROM maven:3.8-jdk-11 AS builder

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:resolve

COPY . .

RUN mvn clean package

FROM openjdk:11-jdk-slim

WORKDIR /app

COPY --from=builder /app/target/Maven-Web-App .

EXPOSE 9090

CMD ["java", "-jar", "Maven-Web-App.war"]
