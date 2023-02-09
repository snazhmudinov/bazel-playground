def _uppercase_impl(ctx):
    args = ctx.actions.args()

    inputs = ctx.files.txt_files
    outputs = []

    for input in inputs:
        output = ctx.actions.declare_file("uppercase_{}".format(input.basename))
        outputs.append(output)

        args.add(input.path)
        args.add(output.path)

    ctx.actions.run(
        progress_message = "Uppercasing the .txt files",
        outputs = outputs,
        inputs = inputs,
        executable = ctx.executable._compiler,
        arguments = [args],
    )

    # If both input and output are specified by the BUILD file
    # then there is no need to return anything.
    # Otherwise, we need to tell the Bazel that the files to build
    # for this target includes `output`
    return [DefaultInfo(files = depset(outputs))]

uppercase = rule(
    implementation = _uppercase_impl,
    attrs = {
        "txt_files": attr.label_list(
            allow_empty = False,
            allow_files = [".txt"],
            mandatory = True,
        ),
        "_compiler": attr.label(
            default = ":kt_compiler",
            executable = True,
            cfg = "exec",
        ),
    },
)
