#!/bin/bash
pipx install poetry

virtualenv ~/venv
poetry env use ~/venv/bin/python

poetry install
