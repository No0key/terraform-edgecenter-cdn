SHELL := /bin/bash
.DEFAULT_GOAL := init

init:
	@make install-requirements
	@make pre-commit-configuration

pre-commit-configuration:
	@pre-commit clean
	@pre-commit uninstall
	@pre-commit install --install-hooks -f
	@pre-commit install --hook-type commit-msg

install-requirements:
	@pip install -r requirements.txt
