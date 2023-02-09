import sys

if __name__ == '__main__':
    src = sys.argv[1]
    out = sys.argv[2]

    lines = None
    with open(src, "r") as file:
        lines = file.readlines()
        upper = [s.upper() for s in lines]

        with open(out, "w") as w_file:
            w_file.writelines(upper)
