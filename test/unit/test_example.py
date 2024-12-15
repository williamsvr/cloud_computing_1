from fastapi.testclient import TestClient
from examples.examples import app

client = TestClient(app)


def test_example():
    assert 1 + 1 == 2
