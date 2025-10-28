FROM maven:3.8-jdk-11 AS builder

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:resolve

COPY . .

RUN mvn clean package

FROM tomcat:latest
WORKDIR /usr/local/tomcat/webapps

COPY --from=builder /app/target/Maven-Web-App.war .

EXPOSE 8080

CMD ["catalina.sh", "run"]
