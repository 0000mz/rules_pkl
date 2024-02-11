import pytest
import sys
import os
import json

def test_example():
  assert 1 == 1

def test_pkl_generated_json():
  jsonfile = "example.pkl.json"
  assert os.path.exists(jsonfile)
  assert os.path.exists(os.path.join("configs", jsonfile))
  data = None
  with open(jsonfile, 'r') as f:
    data = json.load(f)
  
  assert data is not None
  assert data["name"] == "Example Pkl file"
  assert data["info"] is not None
  assert data["info"]["createdBy"] == "Apple"
  assert data["info"]["currentVersion"] == "0.25.0"

def test_pkl_generated_plist():
  assert os.path.exists('example.pkl.plist')

def test_pkl_generated_yaml():
  # TODO: Use pyyaml to parse the contents of the yaml file.
  assert os.path.exists('example.pkl.yaml')

if __name__ == '__main__':
  sys.exit(pytest.main(sys.argv[1:]))