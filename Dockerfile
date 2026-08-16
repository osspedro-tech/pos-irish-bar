FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN apt-get update && apt-get install -y maven && mvn clean package -DskipTests

# Download and extract Tomcat 10.1
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.15/bin/apache-tomcat-10.1.15.tar.gz && \
    tar xzf apache-tomcat-10.1.15.tar.gz && \
    mv apache-tomcat-10.1.15 tomcat && \
    rm apache-tomcat-10.1.15.tar.gz

# Copy WAR file to Tomcat webapps
RUN cp target/POS.war tomcat/webapps/

# Configure server.xml to set ROOT context to POS app
RUN sed -i 's/<Host name="localhost"/<Host name="localhost" autoDeploy="true" deployOnStartup="true">/' tomcat/conf/server.xml && \
    echo '<Context path="" docBase="POS" reloadable="true"/>' >> tomcat/conf/server.xml

EXPOSE 8080

CMD ["./tomcat/bin/catalina.sh", "run"]