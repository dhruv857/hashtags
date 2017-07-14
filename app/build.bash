#!/bin/bash
cd /django/

if ! [[ -f /venv/bin/python ]] ; then
  virtualenv -p python3 /venv
fi

/venv/bin/pip install -r requirements.txt

/venv/bin/python hashtags/manage.py makemigrations
/venv/bin/python hashtags/manage.py migrate
/venv/bin/python hashtags/manage.py collectstatic --no-input

cd /django/hashtags/

/venv/bin/gunicorn hashtags.wsgi -b 0.0.0.0:80 --no-sendfile
