#!/usr/bin/env bash

until cd src
do
    echo "Waiting for django volume..."
done

until python manage.py migrate --settings=djangoreactredux.settings.dev_docker
do
    echo "Waiting for postgres ready..."
    sleep 2
done

python manage.py loaddata fixtures.json --settings=djangoreactredux.settings.dev_docker
python manage.py collectstatic --noinput
python manage.py runserver 0.0.0.0:8000 --settings=djangoreactredux.settings.dev_docker
