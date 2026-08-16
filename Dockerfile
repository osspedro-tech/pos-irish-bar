FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN apt-get update && apt-get install -y maven && mvn clean package -DskipTests

# Download webapp-runner directly
RUN wget -O target/dependency/webapp-runner.jar https://repo1.maven.org/maven2/com/heroku/webapp-runner/9.0.68.0/webapp-runner-9.0.68.0.jar

EXPOSE 8080

CMD ["java", "-jar", "target/dependency/webapp-runner.jar", "target/POS.war"]