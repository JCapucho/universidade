package aula03;

import utils.UserInput;

import java.util.Scanner;

public class Ex01 {
    public static void main(String[] args) {
        int sum = 0;
        int value = UserInput.promptIntMin("Insira um número natural: ", 0, true);

        for (; value >= 2; value--) {
            if (isPrime(value))
                sum += value;
        }

        System.out.printf("A some dos numéros primos é %s\n", sum);
    }

    private static boolean isPrime(int number) {
        if (number == 2)
            return true;

        if (number < 2 || number % 2 == 0)
            return false;

        int maxDivisor = (int) Math.ceil(Math.sqrt(number));
        for (int divisor = 3; divisor <= maxDivisor; divisor += 2) {
            if (number % divisor == 0)
                return false;
        }

        return true;
    }
}