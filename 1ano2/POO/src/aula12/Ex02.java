package aula12;

import utils.UserInput;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.text.Collator;
import java.util.*;

public class Ex02 {
    public static void main(String[] args) {
        // Use a collator as the comparator to ensure accentuated characters are
        // correctly sorted according to the portuguese layout.
        // This is slower than the standard unicode value compare.
        final Locale locale = new Locale("pt");
        final Collator collator = Collator.getInstance();

        final String path = UserInput.prompt("Insira o nome do ficheiro a ler: ");

        final Map<Character, Map<String, Integer>> initials =
                new TreeMap<>((c1, c2) -> collator.compare(c1.toString(), c2.toString()));
        
        try (Scanner input = new Scanner(new FileReader(path))) {
            input.useDelimiter("[ \\uFEFF\\r\\t\\n.,:'‘’;?!\\-*{}=+&/()\\[\\]”“\"]+");

            while (input.hasNext()) {
                String word = input.next();

                if (word.length() > 2) {
                    word = word.toLowerCase();
                    char initial = word.charAt(0);

                    final Map<String, Integer> initial_map = initials.computeIfAbsent(initial,
                            _initial -> new TreeMap<>(collator));
                    initial_map.compute(word, (_word, accum) -> accum != null ? accum + 1 : 1);
                }
            }
        } catch (FileNotFoundException e) {
            System.err.println("Ficheiro não encontrado");
            System.exit(1);
        }

        try (FileWriter output = new FileWriter("aula12/initials.txt")) {
            for (Map.Entry<Character, Map<String, Integer>> entry : initials.entrySet()) {
                output.write(entry.getKey() + ":");

                for (Map.Entry<String, Integer> wordEntry : entry.getValue().entrySet()) {
                    output.write(" " + wordEntry.getKey() + ", " + wordEntry.getValue() + ";");
                }

                output.write("\n");
            }
        } catch (IOException e) {
            System.err.println("Erro ao escrever os resultados");
            System.exit(1);
        }
    }
}
