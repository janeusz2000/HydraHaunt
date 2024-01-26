def _build_hydra_binary_impl(ctx):
    # Output file for the built Rust binary
    output_binary = ctx.actions.declare_file("hydra_binary")

    # Get the path to the user-provided build script
    build_script_path = ctx.file.build_script.path

    # Command to execute the build script
    build_command = "bash " + build_script_path

    # Execute the build command
    ctx.actions.run_shell(
        outputs = [output_binary],
        command = build_command,
        # Ensure to include the script and any other required files as inputs
        inputs = [ctx.file.build_script] + ctx.files.additional_inputs,
    )

    return [DefaultInfo(files = depset([output_binary]))]

build_hydra_binary = rule(
    implementation = _build_hydra_binary_impl,
    attrs = {
        "build_script": attr.label(
            mandatory = True,
            allow_single_file = True,
            doc = "Label of the shell script to build the Rust binary",
        ),
        "additional_inputs": attr.label_list(
            allow_files = True,
            doc = "List of additional files needed for the build",
        ),
    },
)
