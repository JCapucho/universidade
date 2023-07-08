package aula12;

import utils.UserInput;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

public class Ex01 {
    public static void main(String[] args) {
        final String path = UserInput.prompt("Insira o nome do ficheiro a ler: ");

        final Set<String> words_found = new HashSet<>();
        int total_words = 0;

        try (Scanner input = new Scanner(new FileReader(path))) {
            input.useDelimiter("[ \\uFEFF\\r\\t\\n.,:'‘’;?!\\-*{}=+&/()\\[\\]”“\"]+");

            while (input.hasNext()) {
                String word = input.next();
                words_found.add(word.toLowerCase());
                total_words += 1;
            }
        } catch (FileNotFoundException e) {
            System.err.println("Ficheiro não encontrado");
            System.exit(1);
        }

        System.out.println("Número Total de Palavras: " + total_words);
        System.out.println("Número de Diferentes Palavras: " + words_found.size());
    }
}
