FROM maven:3.9.9-eclipse-temurin-17 AS builder

RUN apt-get update && apt-get upgrade -y 

WORKDIR /java-standalone/

COPY . .

RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre

WORKDIR /java-standalone/

COPY --from=builder /java-standalone/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "app.jar" ]

CMD [ "--special" ]
