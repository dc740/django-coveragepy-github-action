# Python Django coverage.py GitHub Action

Github Action to integrate Coverage.py with Django on every pull request. It comes with a bundled PostgreSQL DB to run the test against.

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
    steps:
      - name: Checkout action
        uses: actions/checkout@v2
      - name: Django Coverage action
        uses: actions/python-django-coverage-gitHub-action@0.9
        with:
          django-app: 'sample_app'
          minimum-coverage: '86'
