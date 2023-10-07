# poetry

I want to explore using poetry for managing dependencies.

## Initialization

```sh
# We don't install using pipx or in a separate virtualenv as we are working a
# container.
pip install poetry

# Auto completions as of install instructions
poetry completions bash >> ~/.bash_completion

poetry new . # Fails, needs an non existent directory to work
poetry new myproj
```

Now this created a rather simple layout of:

```
myproj/
├── README.md
├── myproj
│   └── __init__.py
├── pyproject.toml
└── tests
    └── __init__.py
```

`cat myproj/pyproject.toml`
```toml
[tool.poetry]
name = "myproj"
version = "0.1.0"
description = ""
authors = ["Gregor Müllegger <gregor@muellegger.de>"]
readme = "README.md"

[tool.poetry.dependencies]
python = "^3.11"


[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

Ok, but I already have a few files like README and I don't want a separate tests
directory. So I just move the `pyproject.toml` file up.

`poetry install` works out of the box, but it creates a new virtualenv. I don't want to do that when being in devcontainer.

Now I want to use the system python, so we are setting `POETRY_VIRTUALENVS_CREATE=false` in `.devcontainer/devcontainer.json`.

```
vscode ➜ /workspaces/python-kata-template (attempt/pyproject-toml-poetry) $ poetry install
Skipping virtualenv creation, as specified in config file.
Installing dependencies from lock file

Installing the current project: myproj (0.1.0)
vscode ➜ /workspaces/python-kata-template (attempt/pyproject-toml-poetry) $ pip freeze | grep mypr
-e git+https://github.com/gregmuellegger/python-kata-template.git@7f28b86e58192a325200d21994b9901a59d1299c#egg=myproj
```

Ok, works so far.

Importing the kata package from anywhere works, didn't need to specify the package in the toml file.

```
vscode ➜ /workspaces/python-kata-template (attempt/pyproject-toml-poetry) $ cd /tmp
vscode ➜ /tmp $ python 
Python 3.11.6 (main, Oct  3 2023, 03:15:52) [GCC 10.2.1 20210110] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import kata
>>> kata.__file__
'/workspaces/python-kata-template/kata/__init__.py'
>>> 
```

Committed.

## Adding dependencies

Let's add pytest as dev dependency:

```
poetry add pytest --dev
```

Well this broke poetry, it now only returns this:

```
vscode ➜ /workspaces/python-kata-template (attempt/pyproject-toml-poetry) $ poetry add pytest --dev

No module named 'packaging'
```

Presumably because it would install things globally, but we are not working as
root in the container. So what will we do?

I would suggest actually switching to a venv that we manage ourselves.

Like this during init:

```
pipx install poetry
poetry env use ~/venv/bin/python
```

Ok now it works:

```
vscode ➜ /workspaces/python-kata-template (attempt/pyproject-toml-poetry) $ poetry add pytest --group dev
Using version ^7.4.2 for pytest

Updating dependencies
Resolving dependencies... (0.3s)

Package operations: 4 installs, 0 updates, 0 removals

  • Installing iniconfig (2.0.0)
  • Installing packaging (23.2)
  • Installing pluggy (1.3.0)
  • Installing pytest (7.4.2)

Writing lock file
```

CONTINUE: I wonder if it is better to place the environment in .venv which would
persist devcontainer rebuilds? However then it becomes less reproduciable.

Continue with how to build a shipable package.

QUESTIONS:
- How to auto select correct python interpreter in devcontainer?
- How to build package?
