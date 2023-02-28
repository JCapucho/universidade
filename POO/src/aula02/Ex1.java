package aula02;

import utils.UserInput;

public class Ex1 {
    public static void main(String[] args) {
        double quilometros = UserInput.promptDoubleMin("Insira o número de quilómetros: ", 0);
        double milhas = quilometros / 1.609;
        System.out.printf("%f km = %f mi", quilometros, milhas);
    }
}