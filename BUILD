load("//:rules_pkl.bzl", "pkl_library")
load("@pip_deps//:requirements.bzl", "requirement")

# TODO: Remove, //:pkl_transform_sh is equivalent implementation.
py_binary(
    name = "pkl_transform",
    srcs = ["pkl_transform.py"],
    visibility = ["//visibility:public"],
)

sh_binary(
    name = "pkl_transform_sh",
    srcs = ["pkl_transform.sh"],
    visibility = ["//visibility:public"],
)

py_test(
    name = "pkl_import_test",
    srcs = ["pkl_import_test.py"],
    data = [
        "//configs:cicd_pkl",
        "//configs:example_pkl",
        "//configs/subdir:example_pkl",
    ],
    deps = [
        requirement("pytest"),
    ],
)
