# Python Django coverage.py GitHub Action

Github Action to integrate Coverage.py with Django on every pull request. It comes with a bundled PostgreSQL DB to run the test against.

## Inputs

### `django-apps`

The name of the Django app or a comma separated list of Django apps you would like to cover `app1,app2`.
Default:

### `minimum-coverage`

Percentage of required coverage to consider it a valid commit.
Default: `10`

### `requirements-txt`

Path to the requirements.txt file.
Default: `requirements.txt`

### `custom-command`

if set the user will pass in a command to be ran instead of the defaut one.
default:

## Outputs

### `success`

Boolean value that indicates that the test run and coverage was successful.

## Example usage

    uses: tadomikikuto-bit/python-django-coverage-gitHub-action@master
    with:
      django-apps: 'sample_app'
      minimum-coverage: '86'
      requirements-txt: 'requirements.txt'
