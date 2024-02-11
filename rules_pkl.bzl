def _pkl_library_impl(ctx):
  config_template = ctx.actions.declare_file(ctx.file.config.basename + ".templ")

  # Copy the config file to the sandbox to be used in the pkl generation.
  ctx.actions.expand_template(
    output = config_template,
    template = ctx.file.config,
  )

  config_format_outputs = []
  for format in ctx.attr.formats:
    ext = ""
    if format in ["json", "yaml", "plist"]:
      ext = "." + format

    # TODO: Set the proper path for the out file otherwise there may be a chance
    # of pkl files with same name in different directories to overwrite each other,
    # not too sure if this is true. Need to test it.
    config_format_output = ctx.actions.declare_file(
      ctx.file.config.basename + ext
    )
    config_format_outputs.append(config_format_output)

    ctx.actions.run(
      executable = ctx.executable.pkl_transform_binary,
      arguments = [
        "--format",
        format,
        "--config_file",
        config_template.path,
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
      inputs = [config_template],
    )

  return [DefaultInfo(files = depset(config_format_outputs))]

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
    "pkl_transform_binary": attr.label(
      executable = True,
      cfg = "exec",
      default = Label("//:pkl_transform"),
    ),
  },
)
