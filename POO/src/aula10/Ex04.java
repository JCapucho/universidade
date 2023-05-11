package aula10;

import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;

public class Ex04 {
    public static void main(String[] args) throws IOException {
        final Set<String> notedWords = new HashSet<>();
        final Scanner input = new Scanner(new FileReader("words.txt"));

        while (input.hasNext()) {
            String word = input.next();
            System.out.println(word);

            if (word.length() > 2)
                notedWords.add(word);
        }

        System.out.println("Palavras terminadas em 's': ");
        for (String word : notedWords) {
            if (word.endsWith("s"))
                System.out.println(word);
        }

        notedWords.removeIf(word -> !word.chars().allMatch(Character::isLetter));

        System.out.println("Palavras apenas com letras: ");
        for (String word : notedWords)
            System.out.println(word);
    }
}
