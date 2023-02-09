def _uppercase_impl(ctx):
    inputs = ctx.files.txt_files
    outputs = []

    input_paths = []
    output_paths = []

    for file in inputs:
        output = ctx.actions.declare_file("uppercase_{}".format(file.basename))
        outputs.append(output)

        input_paths.append(file.path)
        output_paths.append(output.path)

    args = ctx.actions.args()

    args.add(ctx.executable._compiler.path)
    args.add_all(input_paths)
    args.add_all(output_paths)

    ctx.actions.run_shell(
        outputs = outputs,
        inputs = inputs,
        tools = [ctx.executable._compiler],
        progress_message = "Transforming .txt files",
        arguments = [args],
        command = "$1 ${@:2}",  # first argument is the shell executable.
    )

    # If both input and output are specified by the BUILD file
    # then there is no need to return anything.
    # Otherwise, we need to tell the Bazel that the files to build
    # for this target includes `output`
    return [DefaultInfo(files = depset(outputs))]

uppercase = rule(
    implementation = _uppercase_impl,
    doc = "Produces the corresponding .txt files with contents uppercased.",
    attrs = {
        "txt_files": attr.label_list(
            allow_files = [".txt"],
            mandatory = True,
        ),
        "_compiler": attr.label(
            default = ":executor",
            executable = True,
            cfg = "exec",
        ),
    },
)
