import sys


def run(args):
    for i in range(0, len(args), 2):
        input_txt = args[i]
        output_txt = args[i + 1]

        with open(input_txt, "r") as read_file:
            uppercase_text = read_file.read().upper()

            with open(output_txt, "w") as write_file:
                write_file.write(uppercase_text)


if __name__ == "__main__":
    args = sys.argv[1:]
    run(args)
