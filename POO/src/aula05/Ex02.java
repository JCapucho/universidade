package aula05;

import utils.UserInput;

import java.util.Date;

public class Ex02 {
    public static void main(String[] args) {
        Calendar current = new Calendar(2023, 1);

        while (true) {

            System.out.println("1 - create new calendar");
            System.out.println("2 - print calendar month");
            System.out.println("3 - print calendar");
            System.out.println("4 - Adicionar evento");
            System.out.println("5 - Remover evento");
            System.out.println("0 - exit");

            int selection = UserInput.promptIntRange("Insira a sua seleção: ", 0, 5);

            switch (selection) {
                case 0 -> {
                    return;
                }
                case 1 -> {
                    int year = UserInput.promptInt("Insira o ano: ");
                    int weekday = UserInput.promptIntRange("Insira o primeiro dia da semana do ano: ", 1, 7);
                    current = new Calendar(year, weekday);
                }
                case 2 -> {
                    int month = UserInput.promptIntRange("Insira o mês: ", 1, 12);
                    System.out.println(current.printMonth(month));
                }
                case 3 -> {
                    System.out.println(current);
                }
                case 4 -> {
                    int month = UserInput.promptIntRange("Insira o mês: ", 1, 12);
                    int day = UserInput.promptIntRange("Insira o dia: ", 1, DateYMD.monthDays(month, current.year()));
                    DateYMD date = new DateYMD(day, month, current.year());
                    current.addEvent(date);
                }
                case 5 -> {
                    int month = UserInput.promptIntRange("Insira o mês: ", 1, 12);
                    int day = UserInput.promptIntRange("Insira o dia: ", 1, DateYMD.monthDays(month, current.year()));
                    DateYMD date = new DateYMD(day, month, current.year());
                    current.removeEvent(date);
                }
            }
        }
    }
}
