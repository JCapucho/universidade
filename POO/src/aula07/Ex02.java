package aula07;

import utils.UserInput;

public class Ex02 {
    public static void main(String[] args) {
        Date current = new DateYMD(1, 1, 1970);

        while (true) {
            System.out.println("Date operations:");
            System.out.println("1) create new date");
            System.out.println("2) show current date");
            System.out.println("3) increment date");
            System.out.println("4) decrement date");
            System.out.println("0) exit");

            int selection = UserInput.promptIntRange("Insert your selection: ", 0, 4);

            switch (selection) {
                case 1 -> {
                    int day = UserInput.promptInt("Insert the day: ");
                    int month = UserInput.promptInt("Insert the month: ");
                    int year = UserInput.promptInt("Insert the year: ");

                    current = new DateYMD(day, month, year);
                }
                case 2 -> {
                    System.out.println(current);
                }
                case 3 -> {
                    current.increment();
                }
                case 4 -> {
                    current.decrement();
                }
                case 0 -> {
                    return;
                }
            }

            System.out.println();
        }
    }
}
