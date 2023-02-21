package aula02;

import utils.UserInput;

import java.util.Scanner;

public class Ex3 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        double massa = UserInput.promptDouble(sc, "Insira a quantidade de água (kg): ");
        double tInicial = UserInput.promptDouble(sc, "Insira a temperatura inicial (°C): ");
        double tFinal = UserInput.promptDouble(sc, "Insira a temperatura final (°C): ");

        double energia = massa * (tFinal - tInicial) * 4184;
        System.out.printf("É preciso %f J", energia);
    }
}
