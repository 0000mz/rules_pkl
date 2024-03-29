import pytest
import sys
import os
import json

def test_example():
  assert 1 == 1

def test_pkl_generated_json():
  jsonfile = "example.pkl.json"
  assert os.path.exists(os.path.join("configs", jsonfile))
  assert os.path.exists(os.path.join("configs", "subdir", jsonfile))
  data = None
  with open(os.path.join("configs", jsonfile), 'r') as f:
    data = json.load(f)
  
  assert data is not None
  assert data["name"] == "Example Pkl file"
  assert data["info"] is not None
  assert data["info"]["createdBy"] == "Apple"
  assert data["info"]["currentVersion"] == "0.25.0"

def test_pkl_generated_plist():
  assert os.path.exists(os.path.join("configs", "example.pkl.plist"))

def test_pkl_generated_yaml():
  # TODO: Use pyyaml to parse the contents of the yaml file.
  assert os.path.exists(os.path.join("configs", "example.pkl.yaml"))

def test_templated_config():
  exts = ["json", "plist", "yaml"]
  for ext in exts:
    assert os.path.exists(os.path.join("configs", f"cicd.pkl.{ext}"))

  data = None
  with open(os.path.join("configs", "cicd.pkl.json"), 'r') as f:
    data = json.load(f)

  assert data is not None
  assert data["timeout"] == 3


if __name__ == '__main__':
  sys.exit(pytest.main(sys.argv[1:]))