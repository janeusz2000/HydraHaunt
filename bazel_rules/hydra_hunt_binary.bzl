def _hydra_hunt_binary(ctx):
  output_dir = ctx.bin_dir.path + "HydraHunterBinary"
  build_command = ctx.attr.command
  binary_path = ctx.attr.binary_path

  ctx.actions.run_shell(
    command = build_command,
    outputs = [ctx.actions.declare_file(binary_path)]
  )

  copy_script = ctx.actions.declare_file("copy_binary.py")
  ctx.actions.expand_template(
      template = ctx.file._copy_script,
      output = copy_script,
      substitutions = {"%{binary_path}": binary_path, "%{output_dir}": output_dir},
  )

  # Running the Python script to copy the binary
  ctx.actions.run(
      inputs = [ctx.actions.declare_file(binary_path), copy_script],
      outputs = [ctx.actions.declare_file(output_dir + "/" + binary_path)],
      executable = copy_script,
      arguments = [binary_path, output_dir],
  )

  return DefaultInfo(files = depset([ctx.actions.declare_file(output_dir + "/" + binary_path)]))

hydra_hunt_binary = rule(
  implementation = _hydra_hunt_binary,
  attrs = {
    "command": attr.string(mandatory = True),
    "binary_path": attr.string(mandatory = True),
    "_copy_script": attr.label(
      default = "//:copy_binary.py",
      cfg = "host",
      executable = True,
      allow_files = True,
    ),
  },
)
