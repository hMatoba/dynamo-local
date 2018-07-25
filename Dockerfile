FROM openjdk:8-jre-alpine

ENV DYNAMODB_VERSION=latest
ENV DYNAMODB_PORT=8000
ENV JAVA_OPTS=
EXPOSE 8000

RUN mkdir /var/dynamodb_local
WORKDIR /var/dynamodb_local

RUN wget -q https://s3-ap-northeast-1.amazonaws.com/dynamodb-local-tokyo/dynamodb_local_latest.tar.gz && \
    wget -q https://s3-ap-northeast-1.amazonaws.com/dynamodb-local-tokyo/dynamodb_local_latest.tar.gz.sha256 && \
    sha256sum -c dynamodb_local_${DYNAMODB_VERSION}.tar.gz.sha256 && \
    tar zxvf dynamodb_local_${DYNAMODB_VERSION}.tar.gz && \
    rm dynamodb_local_${DYNAMODB_VERSION}.tar.gz dynamodb_local_${DYNAMODB_VERSION}.tar.gz.sha256

CMD ["java", "-Djava.library.path=./DynamoDBLocal_lib", "-jar", "DynamoDBLocal.jar", "-sharedDb"]