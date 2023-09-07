package aula03;

import utils.UserInput;
import utils.UserInputValidationException;

public class Ex05 {
    public static void main(String[] args) {
        int[] date = promptDate();

        int year = date[1];
        int month = date[0];
        int days = getDaysInMonth(month, year);

        System.out.println("Insira o dia da semana em que começa o mês");
        System.out.println("\t1) Segunda");
        System.out.println("\t2) Terça");
        System.out.println("\t3) Quarta");
        System.out.println("\t4) Quinta");
        System.out.println("\t5) Sexta");
        System.out.println("\t6) Sábado");
        System.out.println("\t7) Domingo");

        int startsAt = UserInput.promptIntRange("> ", 1, 7);

        printCalendar(days, month, year, startsAt);
    }

    private static int getDaysInMonth(int month, int year) {
        final int[] daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        boolean isLeapYear = year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);

        if (month == 2 && isLeapYear)
            return 29;

        return daysInMonth[month - 1];
    }

    private static int[] promptDate() {
        while (true) {
            String input = UserInput.prompt("Insira uma data (mm/yyyy): ");

            try {
                return validateDate(input);
            } catch (UserInputValidationException e) {
                System.out.println(e.getMessage());
            }
        }
    }

    private static int[] validateDate(String date) throws UserInputValidationException {
        String[] components = date.split("/");

        if (components.length != 2)
            throw new UserInputValidationException("A data não está no formato mm/yyyy");

        String monthStr = components[0];
        String yearStr = components[1];

        if (!monthStr.matches("[0-9]+"))
            throw new UserInputValidationException("O mês só pode conter números");

        if (!yearStr.matches("[0-9]+"))
            throw new UserInputValidationException("O ano só pode conter números");

        int month;
        try {
            month = Integer.parseInt(monthStr);
        } catch (NumberFormatException e) {
            throw new UserInputValidationException("O mês não é um número válido");
        }

        int year;
        try {
            year = Integer.parseInt(yearStr);
        } catch (NumberFormatException e) {
            throw new UserInputValidationException("O ano não é um número válido");
        }

        if (month < 1 || month > 12)
            throw new UserInputValidationException("O mês tem que estar entre 1 e 12");

        return new int[]{month, year};
    }

    private static void printCalendar(int days, int month, int year, int startsAt) {
        final String[] monthName = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};

        String header = String.format("%s %d", monthName[month - 1], year);
        int padding = (20 - header.length()) / 2;
        System.out.printf("%s%s\n", " ".repeat(padding), header);

        System.out.println("Su Mo Tu We Th Fr Sa");

        final int DAYS_IN_WEEK = 7;

        startsAt = startsAt % DAYS_IN_WEEK; // Make sure sunday has index 0

        for (int i = 0; i <= days + startsAt; i++) {
            int day = i - startsAt;

            if (day < 1) {
                System.out.print("  ");
            } else {
                System.out.printf("%2d", day);
            }

            if (i % DAYS_IN_WEEK == 0)
                System.out.println();
            else
                System.out.print(" ");
        }
    }
}
