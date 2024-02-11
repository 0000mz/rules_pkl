load(
  "//:rules_pkl.bzl",
  "pkl_library",
  "pkl_template",
)

# Transform the example.pkl file to its json, yaml and plist
# equivalents.
pkl_library(
  name = "example_pkl",
  formats = ["json", "yaml", "plist"],
  config = "example.pkl",
  visibility = ["//:__subpackages__"],
)

# Declare a pkl template to be used in a pkl_library.
pkl_template(
  name = "acmecicd_pkl_tmpl",
  config = "acmecicd.pkl",
)

# Create a pkl config that takes the :acmecicd_pkl_tmpl template pkl
# file, and uses cicd.pkl to fill in the template. Then outputs the transformed
# pkl file as its json, yaml and plist equivalents.
pkl_library(
  name = "cicd_pkl",
  # TODO: The :amecicd_pkl_tmpl defines an output "new JsonRenderer". That means all evaluations
  # of the pkl file will result in a Json output, thus making this formats declaration misleading
  # in this case.
  # A possible workaround to this would be to restrict the definition of an output in the
  # template so that it can be automatically inserted by the rule.
  # After testing, it seems like omitting the output alltogether will allow pkl to automatically
  # select the correct renderer. That might be the better solution to this.
  formats = ["json", "yaml", "plist"],
  config = "cicd.pkl",
  template = ":acmecicd_pkl_tmpl",
  visibility = ["//:__subpackages__"],
)
