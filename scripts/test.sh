#!/bin/bash  

#pwd
pwd="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#DO NOT MODIFY
PROJECT_HOME=$pwd/..
PROJECT_ENV_PATH=$PROJECT_HOME/env

#usage message
if [ $# -ne 1 ]; then echo "Usage: $0 run-tests" ; exit 1 ; fi

function activate_env {
  echo "Activating virtualenv..."
  source $PROJECT_ENV_PATH/bin/activate
  echo "virtualenv activated..."
}

opt=$1
if [ $opt == "run-tests" ] ; then
  export PYTHONPATH=$PROJECT_HOME:$PYTHONPATH  
  activate_env
  nosetests source
else
  echo "Usage: $0 run-tests"
  exit 1
fi

