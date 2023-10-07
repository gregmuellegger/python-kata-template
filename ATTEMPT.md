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
