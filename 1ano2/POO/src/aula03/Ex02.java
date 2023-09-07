package aula03;

import utils.UserInput;
import utils.InputValidator;

public class Ex02 {
    public static void main(String[] args) {
        InputValidator<Integer> montanteValidator = InputValidator.composite(
                InputValidator.minValidator(0, true),
                InputValidator.functional(value -> value % 1000 == 0, "Value must be a multiple of 1000")
        );
        double montante = UserInput.promptIntValidator("Insira o montante: ", montanteValidator);

        double taxa = UserInput.promptDoubleRange("Insira a taxa de juro mensal (%): ", 0, 5);
        double multiplier = 1 + taxa / 100;

        for (int i = 1; i <= 12; i++) {
            montante *= multiplier;
            System.out.printf("Mês %d: %f\n", i, montante);
        }
    }
}
