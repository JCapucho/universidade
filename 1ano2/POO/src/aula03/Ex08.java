package aula03;

import utils.UserInput;

public class Ex08 {
    public static void main(String[] args) {
        String input = UserInput.prompt("Introduza uma frase: ");
        String[] comps = input.split("( )+");

        String result = "";

        for (String comp : comps) {
            if (comp.length() < 3)
                continue;

            result += comp.charAt(0);
        }

        System.out.printf("Acrónimo: %s\n", result);
    }
}
