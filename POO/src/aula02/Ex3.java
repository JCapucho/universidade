package aula02;

import utils.UserInput;

public class Ex3 {

    public static void main(String[] args) {
        double massa = UserInput.promptDoubleMin("Insira a quantidade de água (kg): ", 0);
        double tInicial = UserInput.promptDouble("Insira a temperatura inicial (°C): ");
        double tFinal = UserInput.promptDouble("Insira a temperatura final (°C): ");

        double energia = massa * (tFinal - tInicial) * 4184;
        System.out.printf("É preciso %f J", energia);
    }
}
