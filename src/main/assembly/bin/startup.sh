#!/bin/sh
#==============================================================================
#set HOME
CURR_DIR=`pwd`
SERVER_NAME="send-mail"
cd `dirname "$0"`/..
SERVICE_HOME=`pwd`
cd $CURR_DIR
if [ -z "$SERVICE_HOME" ] ; then
    echo
    echo "Error: SERVICE_HOME environment variable is not defined correctly."
    echo
    exit 1
fi
#==============================================================================
CONF=""
JAVA_OPTS=" -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true "
JAVA_DEBUG_OPTS=""
if [ "$1" = "debug" ]; then
    JAVA_DEBUG_OPTS=" -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n "
fi

if [ -n "$1" ]; then
    echo "config file name is $1"
    CONF="$1"
fi

if [ -z "$CONF" ]; then
    echo "config file not set,program will exit;"
    exit 1
fi

#==============================================================================

# 启动类
APP_MAINCLASS=top.weidong.mail.SendMail


#==============================================================================
#set CLASSPATH
export CLASSPATH=$CLASSPATH:$SERVICE_HOME/lib/*
export LANG=en_US.UTF-8

JAVA_CMD="nohup java $JAVA_OPTS $JAVA_DEBUG_OPTS -classpath $CLASSPATH $APP_MAINCLASS $CONF &"
echo $JAVA_CMD
eval $JAVA_CMD


exit 0