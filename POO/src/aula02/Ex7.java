package aula02;

import utils.UserInput;

import java.util.Scanner;

public class Ex7 {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("Insira as cordenadas do primeiro ponto");
        double p1X = UserInput.promptDouble(sc, "x: ");
        double p1Y = UserInput.promptDouble(sc, "y: ");

        System.out.println("Insira as cordenadas do segundo ponto");
        double p2X = UserInput.promptDouble(sc, "x: ");
        double p2Y = UserInput.promptDouble(sc, "y: ");

        double xDiff = (p1X - p2X);
        double xDiff2 = xDiff * xDiff;
        double yDiff = (p1Y - p2Y);
        double yDiff2 = yDiff * yDiff;
        double distance = Math.sqrt(xDiff2 + yDiff2);

        System.out.printf("A distância entre os pontos é  %f", distance);
    }
}
