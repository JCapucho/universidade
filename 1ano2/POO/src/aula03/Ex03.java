package aula03;

import utils.Random;
import utils.UserInput;

public class Ex03 {
    private static final int MIN_GUESS = 1;
    private static final int MAX_GUESS = 100;

    public static void main(String[] args) {
        while (true) {
            int objective = Random.randomIntRange(MIN_GUESS, MAX_GUESS);

            int attempts = guess(objective);
            System.out.println("Acertou!");
            System.out.printf("Fez %d tentativas\n", attempts);

            String res = UserInput.prompt("Pretende continuar? Prima (S)im\n");

            if (!res.matches("S(im)?")) {
                System.out.println("Tenha um bom dia");
                break;
            }
        }
    }

    private static int guess(int objective) {
        int attempts = 0;

        while (true) {
            int guess = UserInput.promptIntRange("Insira um número: ", MIN_GUESS, MAX_GUESS);
            attempts++;

            if (guess == objective) {
                return attempts;
            } else if (guess > objective) {
                System.out.println("Alto");
            } else if (guess < objective) {
                System.out.println("Baixo");
            }
        }
    }
}
