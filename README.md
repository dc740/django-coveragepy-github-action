# Python Django Coverage GitHub Action

Github Action to integrate Coverage with Django on a Python Slim Docker image

## Inputs

### `django-app`

The name of the Django app.
Default:

### `minimum-coverage`

Percentage of required coverage to consider it a valid commit.
Default: `10`

## Outputs

### `success`

Boolean value that indicates that the test run and coverage was successful.

## Example usage

uses: actions/checkout@v2
uses: actions/python-django-coverage-gitHub-action@v1
with:
  django-app: 'sample_app'
  minimum-coverage: '86'
