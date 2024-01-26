def _hydra_hunt_binary(ctx):
    output_dir = ctx.bin_dir.path + "/HydraHunterBinary"

    # The relative path of the binary from the workspace root
    binary_path = ctx.attr.binary_path

    # Full path for the final binary
    final_binary_path = output_dir + "/" + binary_path
    final_binary = ctx.actions.declare_file(final_binary_path)

    # Build command specified by the user
    build_command = ctx.attr.command

    # Run the user-specified build command
    ctx.actions.run_shell(
        command = build_command,
        outputs = [final_binary]
    )

    return [DefaultInfo(executable = final_binary)]

hydra_hunt_binary = rule(
    implementation = _hydra_hunt_binary,
    attrs = {
        "command": attr.string(mandatory = True),  # User provides the build command
        "binary_path": attr.string(mandatory = True),  # Path to the final binary
    },
    executable = True,
)
