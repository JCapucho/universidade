package aula02;

import utils.UserInput;

public class Ex5 {
    public static void main(String[] args) {
        double v1 = UserInput.promptDoubleMin("Insira a primeira velocidade (km/h): ", 0, true);
        double d1 = UserInput.promptDoubleMin("Insira a primeira distância (km): ", 0, true);
        double v2 = UserInput.promptDoubleMin("Insira a segunda velocidade (km/h): ", 0, true);
        double d2 = UserInput.promptDoubleMin("Insira a segunda distância (km): ", 0, true);

        double dTotal = d1 + d2;
        double tTotal = d1 / v1 + d2 / v2;
        double vTotal = dTotal / tTotal;

        System.out.printf("A velocidade média %f", vTotal);
    }
}
