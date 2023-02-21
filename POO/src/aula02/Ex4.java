package aula02;

import utils.UserInput;

import java.util.Scanner;

public class Ex4 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        double investido = UserInput.promptDoubleMin(sc, "Montante investido: ", 0);
        double taxa = UserInput.promptDoubleRange(sc, "Taxa de juro (%): ", 0, 100);

        double total = investido;
        for (int i = 0; i < 3; i++)
            total *= 1 + taxa;

        System.out.printf("Ao final de 3 meses terá %f", total);
    }
}
