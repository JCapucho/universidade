package aula02;

import utils.UserInput;

public class Ex4 {

    public static void main(String[] args) {
        double investido = UserInput.promptDoubleMin("Montante investido: ", 0);
        double taxa = UserInput.promptDoubleRange("Taxa de juro (%): ", 0, 100);

        double total = investido;
        for (int i = 0; i < 3; i++)
            total *= 1 + taxa;

        System.out.printf("Ao final de 3 meses terá %f", total);
    }
}
