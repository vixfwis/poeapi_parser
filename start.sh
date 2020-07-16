#!/bin/bash

export DB_HOST="localhost"
export DB_NAME="poeapi"
export DB_USER="poeapi"
export DB_PASSWORD=""

pipenv run python3 poeapi_parser/startpoint.py
