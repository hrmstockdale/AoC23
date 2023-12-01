SHELL := /bin/bash

DAY_LIST := $(shell seq -w 1 25)

GENERATE_DAYS:= $(foreach DAY_NUM,$(DAY_LIST),gen$(DAY_NUM))

SOLUTION_PARTS := $(foreach DAY,$(DAY_LIST),d$(DAY)p1 d$(DAY)p2)

TESTS := $(foreach DAY_NUM,$(DAY_LIST),test$(DAY_NUM))
TEST_PARTS := $(foreach TEST,$(TESTS),$(TEST)p1 $(TEST)p2)

.PHONY: install $(GENERATE_DAYS) $(SOLUTIONS) $(TESTS) $(TEST_PARTS)

install:
	pyenv install "$(shell cat .python-version | xargs)" -s
	poetry env use "python$(shell cat .python-version | xargs | cut -d'.' -f1-2)"
	poetry install

lint: flake8 black isort

cfn-lint:
	poetry run cfn-lint template.yaml

flake8:
	poetry run flake8

black:
	poetry run black --diff --check .

black-fix:
	poetry run black .

isort:
	poetry run isort --diff --check .

isort-fix:
	poetry run isort .

bandit:
	poetry run bandit -r src -q -n 3

safety:
	poetry export -f requirements.txt | poetry run safety check --stdin

$(GENERATE_DAYS):
	@poetry run python -m utils.generate $(subst gen,,$@)

$(SOLUTION_PARTS):
	@poetry run python -m $(subst p,.solution,$(subst d,day,$@))

$(TESTS):
	@poetry run pytest $(subst test,day,$@) -ra -s

$(TEST_PARTS):
	@poetry run pytest $(subst p,/test_solution,$(subst test,day,$@)).py -ra -s
