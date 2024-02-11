def _pkl_library_impl(ctx):
  config_file = ctx.actions.declare_file(ctx.file.config.basename + ".templ")

  # Copy the config file to the sandbox to be used in the pkl generation.
  ctx.actions.expand_template(
    output = config_file,
    template = ctx.file.config,
  )

  config_format_outputs = []
  for format in ctx.attr.formats:
    ext = ""
    if format in ["json", "yaml", "plist"]:
      ext = "." + format

    config_format_output = ctx.actions.declare_file(
      ctx.file.config.basename + ext
    )
    config_format_outputs.append(config_format_output)

    inputs = [config_file]
    if ctx.file.template != None:
      inputs.append(ctx.file.template)

    ctx.actions.run(
      executable = ctx.executable.pkl_transform_binary,
      arguments = [
        "--format",
        format,
        "--config_file",
        config_file.path,
        "--output",
        config_format_output.path,
      ],
      progress_message = "Generating pkl file",
      # TODO: This will allow bazel to access the user's
      # installed pkl binary to use for generating the config.
      # This is not hermetic. Instead, have bazel pull in the
      # pkl executale to be used.
      use_default_shell_env = True,
      outputs = [config_format_output],
      inputs = inputs,
    )

  return [DefaultInfo(files = depset(
        config_format_outputs,
    ))]

# This should take the template file and pass it through so that it can
# be used as a dependency in pkl_library.
def _pkl_template_impl(ctx):
  template = ctx.actions.declare_file(ctx.file.config.basename)
  ctx.actions.expand_template(
    output = template,
    template = ctx.file.config,
  )
  return [DefaultInfo(files = depset([template]))]

# Rule for defining a pkl template:
# https://pkl-lang.org/main/current/language-tutorial/03_writing_a_template.html
# A template is meant to be defined and then plugged into a pkl_library to fill
# out the templated segments.
pkl_template = rule(
  implementation = _pkl_template_impl,
  attrs = {
    "config": attr.label(
      allow_single_file = True,
      mandatory = True,
      doc = "The pkl template file.",
    ),
  },
)

pkl_library = rule(
  implementation = _pkl_library_impl,
  attrs = {
    "formats": attr.string_list(
      mandatory=True,
      allow_empty=False,
      doc="The config formats to transform the pkl file into: e.g. json, yaml, plist",
    ),
    "config": attr.label(
      allow_single_file = True,
      mandatory = True,
      doc = "The pkl file to create a library for.",
    ),
    "template": attr.label(
      allow_single_file = True,
      mandatory = False,
      doc = "The template to use for the pkl config.",
    ),
    "pkl_transform_binary": attr.label(
      executable = True,
      cfg = "exec",
      default = Label("//:pkl_transform"),
    ),
  },
)
