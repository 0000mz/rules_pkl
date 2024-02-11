load("//:rules_pkl.bzl", "pkl_library")

py_binary(
  name = "pkl_transform",
  srcs = ["pkl_transform.py"],
  visibility = ["//visibility:public"],
)

pkl_library(
  name = "example_pkl",
  formats = ["json", "yaml", "plist"],
  config = "example.pkl",
)

py_test(
  name = "pkl_import_test",
  srcs = ["pkl_import_test.py"],
  data = [
    ":example_pkl",
    "//configs:example_pkl",
  ],
)
