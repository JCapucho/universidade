package aula02;

import utils.UserInput;

public class Ex6 {
    public static void main(String[] args) {
        int segundos = UserInput.promptIntMin("Insira o tempo (s): ", 0);

        int rSegundos = segundos % 60;
        int rMinutos = (segundos / 60) % 60;
        int rHoras = segundos / 3600;

        System.out.printf("O tempo é %02d:%02d:%02d", rHoras, rMinutos, rSegundos);
    }
}
