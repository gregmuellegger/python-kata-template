# Python Kata Template

[My](https://gremu.net/) personal template to practice on katas using a modern
Python setup.

## Setup

Start the repo in devcontainers in vscode and you are ready to go.

## Katas

- [`pyproject-toml`](https://github.com/gregmuellegger/python-kata-template/blob/kata/pyproject-toml/KATA.md)

(or look for [all `kata/` branches on GitHub](https://github.com/gregmuellegger/python-kata-template/branches/all?query=kata%2F))

## Starting an attempt

First switch to the kata you want to do an attempt on:

```shell
git checkout kata/name-of-kata
```

Then start the attempt with:

```shell
just attempt name-of-your-attempt
```

## Creating a new kata

```
just start kata-name
```

(Or run vs code task `start`)
