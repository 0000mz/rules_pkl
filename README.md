<p align="center">
  <img src="doc/pkl-bazel-logo-long-dark.png#gh-dark-mode-only" height="50px" />
  <img src="doc/pkl-bazel-logo-long.png#gh-light-mode-only" height="50px" />
</p>

Bazel rules for Apple's configuration as code language, [pkl](https://github.com/apple/pkl).

# Installation

```Starlark file=WORKSPACE
# Inside your WORKSPACE file.
load(
  "@bazel_tools//tools/build_defs/repo:git.bzl",
  "new_git_repository",
)

new_git_repository(
  name = "rules_pkl",
  remote = "https://github.com/0000mz/rules_pkl.git",
  commit = "803207a243dc85d51d0d47bd20e9ff1f702aed9e",
)
```
> NOTE: The commit hash may be pointing to an older version, make sure to use an up to date hash.

```Starlark
# Load the rules into your BUILD file.
load(
  "@rules_pkl//:rules_pkl.bzl",
  "pkl_library",
  "pkl_template",
)
```
# Basic Usage
```Starlark

pkl_library(
  name = "example_pkl",
  # Define which formats you want to generate from the pkl file.
  formats = ["json", "yaml", "plist"],
  # The pkl file in question.
  config = "example.pkl",
)

```

```
bazel build //:example_pkl
```
The pkl file has now been converted to its respective json, yaml and plist formats.
```
find bazel-out/ -name "example.pkl*"
```

You can also fill out [templates](https://pkl-lang.org/main/current/language-tutorial/02_filling_out_a_template.html):
```Starlark
pkl_template(
  name = "acmecicd_pkl_tmpl",
  config = "acmecicd.pkl",
)

pkl_library(
  name = "cicd_pkl",
  formats = ["json", "yaml", "plist"],
  config = "cicd.pkl",
  template = ":acmecicd_pkl_tmpl",
  visibility = ["//:__subpackages__"],
)
```

> Source for the [cicd.pkl](/configs/cicd.pkl) and [acmecicd.pkl](/configs/acmecicd.pkl).

# TODOs
- Let bazel pull in the pkl executable to be used. Currently, the user must already have pkl installed on their system for these rules to work.
- Add rules for [language bindings](https://pkl-lang.org/main/current/language-bindings.html).