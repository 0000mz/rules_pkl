load("//:rules_pkl.bzl", "pkl_library")

py_binary(
  name = "pkl_transform",
  srcs = ["pkl_transform.py"],
)

pkl_library(
  name = "example",
  format = "json",
  config = "example.pkl",
)
