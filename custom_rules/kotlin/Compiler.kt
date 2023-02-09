import java.io.File

fun main(args: Array<String>) {
    for (i in 0..args.lastIndex step 2) {
        val inputFile = File(args[i])
        val outputFile = File(args[i + 1])

        val uppercaseLines = inputFile.useLines { seq ->
            seq.toList().map { it.uppercase() }
        }

        outputFile.writer().use { out ->
            uppercaseLines.forEach { out.write(it) }
        }
    }
}