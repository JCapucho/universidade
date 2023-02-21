package aula02;

import utils.UserInput;

import java.util.Scanner;

public class Ex1 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        double quilometros = UserInput.promptDouble(sc, "Insira o número de quilómetros: ");
        double milhas = quilometros / 1.609;
        System.out.printf("%f km = %f mi", quilometros, milhas);
    }
}