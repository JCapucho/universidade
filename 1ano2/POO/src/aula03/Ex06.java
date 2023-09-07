package aula03;

import utils.UserInput;

public class Ex06 {
    public static void main(String[] args) {
        String input = UserInput.prompt("Insira uma frase: ");

        String lowerCase = input.toLowerCase();
        System.out.printf("Frase em minúsculas: '%s'\n", lowerCase);

        char lastChar = input.charAt(input.length() - 1);
        System.out.printf("O último carater é: '%s'\n", lastChar);

        String firstChars = input.substring(0, 3);
        System.out.printf("Os três primeiros carateres são: '%s'\n", firstChars);

        String trimmed = input.trim();
        System.out.printf("Frase trimmed: '%s'\n", trimmed);

        if (input.contains("Hello"))
            System.out.println("A frase contêm a palavra 'Hello'");

        if (input.matches("[0-9].*"))
            System.out.println("A frase começa com um digito");
    }
}
