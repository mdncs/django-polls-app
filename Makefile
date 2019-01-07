.PHONY: env run test lint requires docs
.DEFAULT: env

env:
	@poetry install

run:
	@cd lorelai && poetry run python manage.py runserver

test:
	@poetry run coverage run --branch -m unittest discover && poetry run coverage html

requires:
	@poetry show --no-dev | tr -s " " | sed 's/ /==/' | sed 's/ .*//' > requirements.txt

lint:
	@poetry run isort --virtual-env .venv lorelai/*.py && poetry run flake8

docs:
	@poetry run sphinx-apidoc -f -o docs/source/ lorelai ./tests/*.py
	@cd docs && make html