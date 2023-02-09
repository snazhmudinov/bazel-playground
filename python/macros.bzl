def py_capitalize(name, srcs, outs, exec_tools):
    native.genrule(
        name = name,
        srcs = srcs,
        outs = outs,
        exec_tools = exec_tools,
        cmd = """
            $(location :capitalizer) $(SRCS) $(OUTS)
        """,
    )

def py_test_wrapper(name, srcs, main, **kwargs):
    native.py_test(
        name = name,
        srcs = srcs,
        main = main,
        **kwargs
    )
