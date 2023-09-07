package aula02;

import utils.UserInput;

public class Ex2 {
    public static void main(String[] args) {
        double celsius = UserInput.promptDouble("Insira a temperatura em Celsius (°C): ");
        double fahrenheit = 1.8 * celsius + 32;
        System.out.printf("%f °C = %f °F", celsius, fahrenheit);
    }
}
