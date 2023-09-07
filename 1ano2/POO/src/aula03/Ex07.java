package aula03;

import utils.UserInput;

public class Ex07 {
    public static void main(String[] args) {
        String input = UserInput.prompt("Insira uma frase: ");

        System.out.printf("A frase têm %d digitos\n", countDigits(input));
        System.out.printf("A frase têm %d espaços\n", countSpaces(input));

        if (onlyLowerCase(input))
            System.out.println("A frase só têm minúsculas");

        System.out.printf("A frase com espaços collapsados: '%s'\n", collapseSpaces(input));

        if (isPalindrome(input))
            System.out.println("A frase é um palíndromo");
    }

    public static int countDigits(String s) {
        int counter = 0;
        for (char c : s.toCharArray()) {
            if (Character.isDigit(c))
                counter++;
        }
        return counter;
    }

    public static int countSpaces(String s) {
        int counter = 0;
        for (char c : s.toCharArray()) {
            if (Character.isWhitespace(c))
                counter++;
        }
        return counter;
    }

    public static boolean onlyLowerCase(String s) {
        for (char c : s.toCharArray()) {
            if (Character.isLowerCase(c))
                return false;
        }
        return true;
    }

    public static String collapseSpaces(String s) {
        return s.replaceAll("( )+", " ");
    }

    public static boolean isPalindrome(String s) {
        int length = s.length();

        for (int i = 0; i < length / 2; i++) {
            if (s.charAt(i) != s.charAt(length - i - 1))
                return false;
        }
        return true;
    }
}
