def _hydra_prepare_binary_impl(ctx):
    # Declare the output files and directories
    output_files = []
    copy_commands = []

    for file in ctx.files.target_binary:
        output_file = ctx.actions.declare_file(file.basename)
        output_files.append(output_file)
        # Add command to copy the file or directory
        copy_commands.append("cp -r " + file.path + " " + output_file.path)

    # Combine all copy commands into a single command
    combined_copy_command = " && ".join(copy_commands)

    # Execute the build script followed by the copy commands
    build_and_copy_command = "{} && {}".format(ctx.executable.target_build.path, combined_copy_command)

    ctx.actions.run_shell(
        command = build_and_copy_command,
        inputs = ctx.files.target_binary + [ctx.executable.target_build],
        outputs = output_files,
    )

    return [DefaultInfo(files = depset(output_files))]

hydra_prepare_binary = rule(
    implementation = _hydra_prepare_binary_impl,
    attrs = {
        "target_build": attr.label(
            mandatory = True,
            executable = True,
            cfg = "host",
            doc = "Label of the sh_binary target that builds the target",
        ),
        "target_binary": attr.label_list(
            allow_files = True,
            mandatory = True,
            doc = "List of paths of the built target binary and its dependencies",
        ),
    },
)
