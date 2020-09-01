#!/bin/bash
set -e

echo "#################################################"
echo "Starting ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"


APPS=$1
MIN_COVERAGE=$2
REQUIREMENTS_TXT=$3
CUSTOM_CMD=$4

service postgresql start

if [ -z "${APPS}" ]; then
    APP_LOCATION="."
    VENV_NAME="virtenv1"
else
    APP_LOCATION=$APPS
    VENV_NAME=virtenv_$APPS
fi

if ! [ -e "${GITHUB_WORKSPACE}/${VENV_NAME}" ]; then
    python3 -m venv "${GITHUB_WORKSPACE}/${VENV_NAME}"
fi

source "${GITHUB_WORKSPACE}/${VENV_NAME}/bin/activate"

python -m pip install --upgrade pip

pip install -r $REQUIREMENTS_TXT

echo "Base setup complete. Setting up a sample DB url and running..."
export DATABASE_URL='postgresql://db_admin:8935a847a2dbdcdd78181d6342733913@127.0.0.1:5432/coverage_test'

python3 manage.py migrate

if [ -z "${CUSTOM_CMD}" ]; then
    coverage run --source="${APP_LOCATION}" -m pytest
else
    $CUSTOM_CMD
fi

# Now get the coverage
COVERAGE_RESULT=`coverage report | grep TOTAL | awk 'N=1 {print $NF}' | sed 's/%//g'`
if [[ $COVERAGE_RESULT -gt $MIN_COVERAGE ]]; then
    echo ::set-output name=coverage_result::$COVERAGE_RESULT
else
    echo "#################################################"
    echo "Code coverage below allowed threshold ($COVERAGE_RESULT<$MIN_COVERAGE)"
    exit 1
fi

echo "#################################################"
echo "Completed ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"
