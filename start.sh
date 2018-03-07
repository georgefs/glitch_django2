#!/bin/bash
# initialize script

# Exit early on errors
set -eu

# Python buffers stdout. Without this, you won't see what you "print" in the Activity Logs
export PYTHONUNBUFFERED=true

# Install Python 3 virtual env
VIRTUALENV=.data/venv

if [ ! -d $VIRTUALENV ]; then
  python3 -m venv $VIRTUALENV
fi

if [ ! -f $VIRTUALENV/bin/pip ]; then
  curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | $VIRTUALENV/bin/python
fi

export PATH=$VIRTUALENV/bin:$PATH

# Install the requirements
pip install -r requirements.txt

python3 src/manage.py migrate
# Run a glorious Python 3 server
python3 src/manage.py runserver 8001

