def _impl(ctx):
    args = ctx.actions.args()

    input_files = ctx.files.txt_files
    output_files = []

    for input in input_files:
        output_file = ctx.actions.declare_file("uppercase_{}".format(input.basename))
        output_files.append(output_file)

        args.add(input.path)
        args.add(output_file.path)

    ctx.actions.run(
        progress_message = "Uppercasing the .txt files",
        outputs = output_files,
        inputs = input_files,
        executable = ctx.executable._compiler,
        arguments = [args],
    )

    # If both input and output are specified by the BUILD file
    # then there is no need to return anything.
    # Otherwise, we need to tell the Bazel that the files to build
    # for this target includes `output`
    return [DefaultInfo(files = depset(output_files))]

uppercase = rule(
    implementation = _impl,
    attrs = {
        "txt_files": attr.label_list(
            allow_files = [".txt"],
            mandatory = True,
        ),
        "_compiler": attr.label(
            default = ":compiler",
            executable = True,
            cfg = "exec",
        ),
    },
)
