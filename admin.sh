#!/bin/bash  

#pwd
pwd="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#DO NOT MODIFY
PROJECT_ENV_PATH=$pwd/env

#usage message
if [ $# -ne 1 ]; then echo "Usage: $0 start-server|stop-server" ; exit 1 ; fi

function activate_env {
  echo "Activating virtualenv..."
  source $PROJECT_ENV_PATH/bin/activate
  echo "virtualenv activated..."
}

opt=$1
if [ $opt == "start-server" ] ; then
  echo "Starting..."
  export PYTHONPATH=$pwd:$PYTHONPATH  
  activate_env
  echo "Starting app..."
  #start app
  #export UWSGI_SOCKET=/tmp/py-lite-site-server.sock
  export UWSGI_HTTP=127.0.0.1:3000
  export UWSGI_HOME=$PROJECT_ENV_PATH
  export UWSGI_MODULE=source.webapp.app
  export UWSGI_CALLABLE=app
  export UWSGI_MASTER=1
  export UWSGI_PROCESSES=4
  export UWSGI_MEMORY_REPORT=1
  export TRAC_ENV=/tmp/mytrac
  export UWSGI_PIDFILE=/tmp/py-lite-site-server.pid
  
  exec nohup uwsgi > /tmp/py-lite-site-server.log &
  
  echo "App started successfully..."
  echo "Ready to use..."
elif [ $opt == "stop-server" ] ; then
  echo "Stopping..."
  activate_env
  uwsgi --stop /tmp/py-lite-site-server.pid
  deactivate
  echo "Stopped..."
else
  echo "Usage: $0 start-server|stop-server"
  exit 1
fi



