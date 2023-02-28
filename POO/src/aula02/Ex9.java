package aula02;

import utils.UserInput;

public class Ex9 {
    public static void main(String[] args) {
        int countdown = UserInput.promptIntMin("Insira o valor inicial: ", 0);

        for (int i = countdown; i >= 0; i--) {
            System.out.printf("%d", i);
            if (i % 10 == 0)
                System.out.println();
            else if (i != 0)
                System.out.print(",");
        }
    }
}
