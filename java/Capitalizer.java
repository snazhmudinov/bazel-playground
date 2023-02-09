import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;


class Capitalizer {
    public static void main(String[] args) throws IOException {
        ArrayList<String> outputLines = new ArrayList<>();

        final File input = new File(args[0]);
        final Scanner scanner = new Scanner(input);

        while (scanner.hasNextLine()) {
            final String line = scanner.nextLine();
            outputLines.add(line.toUpperCase());
        }

        final File output = new File(args[1]);
        final PrintWriter writer = new PrintWriter(output, "UTF-8");

        for (String line : outputLines) {
            writer.println(line);
        }
        writer.close();
    }
}