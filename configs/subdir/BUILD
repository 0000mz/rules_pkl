load("//:rules_pkl.bzl", "pkl_library")

pkl_library(
  name = "example_pkl",
  formats = ["json", "yaml", "plist"],
  config = "example.pkl",
  visibility = ["//:__subpackages__"],
)
