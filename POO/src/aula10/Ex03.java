package aula10;

import utils.UserInput;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Ex03 {
    public static void main(String[] args) {
        final Map<Character, List<Integer>> ocurrences = new HashMap<>();
        final String text = UserInput.prompt("Insira a frase para contar: ");

        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            List<Integer> positions = ocurrences.computeIfAbsent(c, _c -> new ArrayList<>());
            positions.add(i);
        }

        System.out.println(ocurrences);
    }
}
