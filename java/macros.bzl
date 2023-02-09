def j_capitalize(name, srcs, outs, exec_tools):
    native.genrule(
        name = name,
        srcs = srcs,
        outs = outs,
        exec_tools = exec_tools,
        cmd = """
                $(location :Capitalizer) $(SRCS) $(OUTS)
            """,
    )
