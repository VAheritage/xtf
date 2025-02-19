# Use the official Tomcat image as the base
FROM tomcat:8-jre8-alpine

# Install necessary tools and dependencies
RUN apk add --no-cache openjdk8 bash wget tar

# Set Ant version
ENV ANT_VERSION 1.10.15

# Download and install Apache Ant
RUN wget https://dlcdn.apache.org/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz \
    && tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz -C /opt \
    && ln -s /opt/apache-ant-${ANT_VERSION} /opt/ant \
    && ln -s /opt/ant/bin/ant /usr/bin/ant \
    && rm apache-ant-${ANT_VERSION}-bin.tar.gz

# Run the builder
CMD cd /temp/xtf/WEB-INF && ant clean jar
