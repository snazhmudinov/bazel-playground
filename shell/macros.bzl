def capitalize(name, srcs, outs):
    native.genrule(
        name = name,
        srcs = srcs,
        outs = outs,
        cmd = """
           tr a-z A-Z < $(SRCS) > $(OUTS)
        """,
    )

def copier(name, srcs, outs):
    native.genrule(
        name = name,
        srcs = srcs,
        outs = outs,
        cmd = """
            arr_in=($(SRCS))
            arr_out=($(OUTS))

            arr_in_size="$${#arr_in[@]}"
            arr_out_size="$${#arr_out[@]}"

            if [ "$$arr_in_size" != "$$arr_out_size" ]; then
                echo "ERROR: Number of srcs and outs are not the same."
                exit 1
            fi

            for (( i = 0; i < arr_in_size; i++ ));do
                cat $${arr_in[i]} >> $${arr_out[i]}
            done
        """,
    )
