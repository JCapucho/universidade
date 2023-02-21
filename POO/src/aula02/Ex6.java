package aula02;

import utils.UserInput;

import java.util.Scanner;

public class Ex6 {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int segundos = UserInput.promptIntMin(sc, "Insira o tempo (s): ", 0);

        int rSegundos = segundos % 60;
        int rMinutos = (segundos / 60) % 60;
        int rHoras = segundos / 3600;

        System.out.printf("O tempo é %02d:%02d:%02d", rHoras, rMinutos, rSegundos);
    }
}
