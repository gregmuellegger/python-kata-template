import pytest
from .code import func


def test_one():
    assert func() == 1
