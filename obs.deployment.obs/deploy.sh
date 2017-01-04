#!/bin/bash

export APPROOT=~/porter

mkdir porterw
cd porterw
mkdir -p app/{templates,static}
virtualenv --python python2.7 --no-site-packages --clear --verbose env
touch {run.py,config.py}
touch app/__init__.py

source env/bin/activate
# Put the all neccessary modules into pip-requirements.txt
pip install flask
#### pip install flask-sqlalchemy
pip install flask-wtf
deactivate

