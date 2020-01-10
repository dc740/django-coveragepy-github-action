#!/bin/bash
set -e

echo "#################################################"
echo "Starting ${GITHUB_WORKFLOW}:${GITHUB_ACTION}"


APP=$1
MIN_COVERAGE=$2

# start PostgreSQL
service postgresql start

# setup run settings
if [ -z "${APP}" ]; then
    # coverage on everything when app is empty
    APP_LOCATION="."
    VENV_NAME="virtenv1"
else
    APP_LOCATION=$APP
    VENV_NAME=virtenv_$APP
fi

# init virtual environment
if ! [ -e "${GITHUB_WORKSPACE}/${VENV_NAME}" ]; then
    python3 -m venv "${GITHUB_WORKSPACE}/${VENV_NAME}"
fi

source "${GITHUB_WORKSPACE}/${VENV_NAME}/bin/activate"

pip install -r requirements.txt

echo "Base setup complete. Setting up a sample DB url and running..."
export DATABASE_URL='postgresql://ctest:coveragetest123@127.0.0.1:5432/demo'

# This will automatically fail (set -e is set by default) if the tests fail, which is OK.
coverage run --source "${APP_LOCATION}" manage.py test "${APP}"

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
