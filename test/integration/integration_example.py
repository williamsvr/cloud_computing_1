from fastapi.testclient import TestClient
from examples.examples import app

client = TestClient(app)


def test_integration_example():
    assert "hello".upper() == "HELLO"
