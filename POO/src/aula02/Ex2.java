package aula02;

import utils.UserInput;

import java.util.Scanner;

public class Ex2 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        double celsius = UserInput.promptDouble(sc, "Insira a temperatura em Celsius (°C): ");
        double fahrenheit = 1.8 * celsius + 32;
        System.out.printf("%f °C = %f °F", celsius, fahrenheit);
    }
}
