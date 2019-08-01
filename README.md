# kafka-connect-jdbc

[![Build Status](https://travis-ci.org/cloudstark/kafka-connect-jdbc.svg?branch=master)](https://travis-ci.org/cloudstark/kafka-connect-jdbc)
[![License](http://img.shields.io/:license-Apache%202-brightgreen.svg)](http://www.apache.org/licenses/LICENSE-2.0.txt)

kafka-connect-jdbc is a plugin of Apache Kafka Connect.

```
  docker run --rm \
    -e "CONNECT_BOOTSTRAP_SERVERS=...:9092" \
    -e "CONNECT_GROUP_ID=connect-jdbc" \
    -e "CONNECT_CONFIG_STORAGE_TOPIC=connect-jdbc-config" \
    -e "CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR=1" \
    -e "CONNECT_OFFSET_STORAGE_TOPIC=connect-jdbc-offset" \
    -e "CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR=1" \
    -e "CONNECT_STATUS_STORAGE_TOPIC=connect-jdbc-status" \
    -e "CONNECT_STATUS_STORAGE_REPLICATION_FACTOR=1" \
    -e "CONNECT_KEY_CONVERTER=org.apache.kafka.connect.json.JsonConverter" \
    -e "CONNECT_VALUE_CONVERTER=org.apache.kafka.connect.json.JsonConverter" \
    -e "CONNECT_INTERNAL_KEY_CONVERTER=org.apache.kafka.connect.json.JsonConverter" \
    -e "CONNECT_INTERNAL_VALUE_CONVERTER=org.apache.kafka.connect.json.JsonConverter" \
    -e "CONNECT_REST_ADVERTISED_HOST_NAME=..." \
    -e "CONNECT_REST_PORT=8083" \
    -e "SECRETS_PROVIDER=env" \
    -e "CONNECTOR_NAME=connect-jdbc" \
    -e "CONNECTOR_CONNECTOR_CLASS=io.confluent.connect.jdbc.JdbcSourceConnector" \
    -e "CONNECTOR_TASKS_MAX=1" \
    -e "CONNECTOR_CONNECTION_URL=jdbc:postgresql://...:5432/postgres" \
    -e "CONNECTOR_CONNECTION_USER=postgres" \
    -e "CONNECTOR_CONNECTION_PASSWORD=postgres" \
    -e "CONNECTOR_DIALECT_NAME=PostgreSqlDatabaseDialect" \
    -e "CONNECTOR_TOPIC_PREFIX=demo" \
    -e "CONNECTOR_MODE=bulk" \
    -e "CONNECTOR_QUERY=SELECT * FROM demo" \
    kafka-connect-jdbc
```
### License

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fcloudstark%2Fkafka-connect-jdbc.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fcloudstark%2Fkafka-connect-jdbc?ref=badge_large)