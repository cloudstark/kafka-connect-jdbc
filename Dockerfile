FROM maven:3.5-jdk-8-alpine AS builder

ARG KAFKA_CONNECT_JDBC_VERSION="5.4.0"
ARG KAFKA_CONNECT_JDBC_TAG=v${KAFKA_CONNECT_JDBC_VERSION}

RUN apk add git

WORKDIR /root

RUN git clone --branch ${KAFKA_CONNECT_JDBC_TAG} https://github.com/confluentinc/kafka-connect-jdbc.git
WORKDIR kafka-connect-jdbc
RUN sed -e "s/\${confluent.maven.repo}/https\:\/\/packages.confluent.io\/maven\//" pom.xml | cat - > pom.tmp.xml
RUN mv pom.tmp.xml pom.xml
RUN mvn clean package -DskipTests=true

FROM maven:3.5-jdk-8-alpine AS builder2

RUN apk add git

WORKDIR /root

RUN git clone https://github.com/yousufdev/kafka-connect-append-schema.git
WORKDIR kafka-connect-append-schema
RUN mvn clean package -DskipTests=true

FROM streamreactor/stream-reactor-base:1.2.3

ARG KAFKA_CONNECT_JDBC_VERSION="5.4.0"

COPY --from=builder /root/kafka-connect-jdbc/target/kafka-connect-jdbc-${KAFKA_CONNECT_JDBC_VERSION}.jar /opt/lenses/lib
COPY --from=builder2 /root/kafka-connect-append-schema/target/AppendSchema-1.0-SNAPSHOT.jar /usr/share/java/kafka

RUN cd /usr/share/java/kafka && \
	curl -sSL https://search.maven.org/remotecontent?filepath=com/microsoft/sqlserver/mssql-jdbc/7.4.1.jre8/mssql-jdbc-7.4.1.jre8.jar -O && \
	curl -sSL https://search.maven.org/remotecontent?filepath=org/postgresql/postgresql/42.2.5/postgresql-42.2.5.jar -O && \
	curl -sSL https://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/8.0.19/mysql-connector-java-8.0.19.jar -O

CMD ["dumb-init", "/opt/lenses/bin/entry-point"]
