#!/usr/bin/env bash

export JAVA_HOME=/usr/java/default
AGENT_DIR="${HOME}/agent"

if [ -z "$TEAMCITY_SERVER" ]; then
    echo "Fatal error: TEAMCITY_SERVER is not set."
    echo "Launch this container with -e TEAMCITY_SERVER=http://servername:port."
    echo
    exit
fi

if [ ! -d "$AGENT_DIR" ]; then
    cd ${HOME}
    echo "Setting up TeamCityagent for the first time..."
    echo "Agent will be installed to ${AGENT_DIR}."
    mkdir -p $AGENT_DIR
    wget $TEAMCITY_SERVER/update/buildAgent.zip
    unzip -q -d $AGENT_DIR buildAgent.zip
    rm buildAgent.zip
    chmod +x $AGENT_DIR/bin/agent.sh
    echo "serverUrl=${TEAMCITY_SERVER}" > $AGENT_DIR/conf/buildAgent.properties
    echo "workDir=../work" >> $AGENT_DIR/conf/buildAgent.properties
    echo "tempDir=../temp" >> $AGENT_DIR/conf/buildAgent.properties
    echo "systemDir=../system" >> $AGENT_DIR/conf/buildAgent.properties
else
    echo "Using agent at ${AGENT_DIR}."
fi

export DISPLAY=:99
Xvfb :99 -screen 0 1024x768x24 &
java -jar /usr/local/lib/selenium/selenium-server-standalone-2.43.1.jar
$AGENT_DIR/bin/agent.sh run
