load("//:rules_pkl.bzl", "pkl_library")

py_binary(
  name = "pkl_transform",
  srcs = ["pkl_transform.py"],
  visibility = ["//visibility:public"],
)

py_test(
  name = "pkl_import_test",
  srcs = ["pkl_import_test.py"],
  data = [
    "//configs:example_pkl",
    "//configs/subdir:example_pkl",
  ],
)
