# Python Django coverage.py GitHub Action

Github Action to integrate Coverage.py with Django on every pull request. It comes with a bundled PostgreSQL DB to run the test against.

## Inputs

### `django-apps`

The name of the Django app or a comma separated list of Django apps that you would like to cover `app1,app2`. If not set, all the app will be covered
Default:

### `minimum-coverage`

Percentage of required coverage to consider it a valid commit.
Default: `10`

### `requirements-txt`

Path to the requirements.txt file if it's not at the dir root.
Default: `requirements.txt`

### `custom-command`

if set, the command passed in will be run instead of the defaut one.
default: coverage run --source="${django-apps}" -m pytest

## Outputs

### `success`

Boolean value that indicates that the test run and coverage was successful.

## Example usage

    uses: tadomikikuto-bit/python-django-coverage-gitHub-action@master
    with:
      django-apps: 'your_app'
      minimum-coverage: '86'
      requirements-txt: 'requirements.txt'
      custom-command: 'your-custom-command'
    