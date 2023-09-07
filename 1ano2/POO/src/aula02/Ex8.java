package aula02;

import utils.UserInput;

public class Ex8 {
    public static void main(String[] args) {
        double c1 = UserInput.promptDouble("Insira o primeiro cateto (A): ");
        double c2 = UserInput.promptDouble("Insira o segundo cateto (B): ");

        double hip = Math.sqrt(c1 * c1 + c2 * c2);
        double angle = Math.asin(c2 / hip);

        System.out.printf("A hipotenusa é %f e faz um ângulo de %f radianos com  o cateto A", hip, angle);
    }
}
