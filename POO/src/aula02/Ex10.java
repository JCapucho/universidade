package aula02;

import utils.UserInput;

import java.util.Scanner;

public class Ex10 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        double primeiro = UserInput.promptDouble(sc, "Insira um número: ");
        double max = primeiro;
        double min = primeiro;
        double sum = primeiro;
        int len = 1;

        while (true) {
            double next = UserInput.promptDouble(sc, "Insira um número: ");

            len++;
            sum += next;

            if (primeiro == next)
                break;

            if (max < next)
                max = next;

            if (min > next)
                min = next;
        }

        double med = sum / len;

        System.out.printf("%d números lidos\n", len);
        System.out.printf("Máximo: %f\n", max);
        System.out.printf("Minímo: %f\n", min);
        System.out.printf("Média: %f\n", med);
    }
}
