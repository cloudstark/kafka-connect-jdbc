FROM maven:3.5-jdk-8-alpine AS builder

ARG KAFKA_CONNECT_JDBC_VERSION="5.2.1"
ARG KAFKA_CONNECT_JDBC_TAG=v${KAFKA_CONNECT_JDBC_VERSION}

RUN apk add git

WORKDIR /root

RUN git clone --branch ${KAFKA_CONNECT_JDBC_TAG} https://github.com/confluentinc/kafka-connect-jdbc.git
WORKDIR kafka-connect-jdbc
RUN sed -e "s/\${confluent.maven.repo}/https\:\/\/packages.confluent.io\/maven\//" pom.xml | cat - > pom.tmp.xml
RUN mv pom.tmp.xml pom.xml
RUN mvn clean package -DskipTests=true

FROM streamreactor/stream-reactor-base:1.2.1

ARG KAFKA_CONNECT_JDBC_VERSION="5.2.1"

COPY --from=builder /root/kafka-connect-jdbc/target/kafka-connect-jdbc-${KAFKA_CONNECT_JDBC_VERSION}.jar /opt/lenses/lib

RUN cd /opt/lenses/lib && \
	curl https://search.maven.org/remotecontent?filepath=com/microsoft/sqlserver/mssql-jdbc/7.0.0.jre8/mssql-jdbc-7.0.0.jre8.jar -O && \
	curl https://search.maven.org/remotecontent?filepath=org/postgresql/postgresql/42.2.5/postgresql-42.2.5.jar -O

CMD ["dumb-init", "/opt/lenses/bin/entry-point"]
