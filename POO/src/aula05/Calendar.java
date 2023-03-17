package aula05;

import java.security.InvalidParameterException;

public class Calendar {
    public static final int DAYS_IN_WEEK = 7;
    public static final String[] MONTH_NAMES = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};

    private int[][] events = new int[DateYMD.MONTHS_IN_YEAR][DateYMD.MAX_DAYS_IN_MONTH];

    private int year;
    private int firstWeekdayOfYear;

    public Calendar(int year, int firstWeekdayOfYear) {
        if (firstWeekdayOfYear < 1 && firstWeekdayOfYear > DAYS_IN_WEEK)
            throw new InvalidParameterException("O dia da semana têm de estar entre 1 e 7");

        this.year = year;
        this.firstWeekdayOfYear = firstWeekdayOfYear;
    }

    public int year() {
        return this.year;
    }

    public int firstWeekdayOfYear() {
        return this.firstWeekdayOfYear;
    }

    public int firstWeekdayOfMonth(int month) {
        if (!DateYMD.validMonth(month))
            throw new InvalidParameterException("O mês passado é inválido");

        int currentWeekday = this.firstWeekdayOfYear - 1;

        for (int i = 1; i < month; i++) {
            currentWeekday += DateYMD.monthDays(i, this.year);
        }

        currentWeekday %= DAYS_IN_WEEK;

        return currentWeekday + 1;
    }

    public void addEvent(DateYMD date) {
        if (date.getYear() != this.year)
            throw new InvalidParameterException("A data não pertence a este calendário");

        events[date.getMonth() - 1][date.getDay() - 1] += 1;
    }

    public void removeEvent(DateYMD date) {
        if (date.getYear() != this.year)
            throw new InvalidParameterException("A data não pertence a este calendário");

        if (events[date.getMonth()][date.getDay()] <= 0)
            throw new InvalidParameterException("A data não têm eventos para remover");

        events[date.getMonth() - 1][date.getDay() - 1] -= 1;
    }

    public String printMonth(int month) {
        if (!DateYMD.validMonth(month))
            throw new InvalidParameterException("O mês passado é inválido");

        String accum = "";

        String header = String.format("%s %d", MONTH_NAMES[month - 1], year);
        int padding = (27 - header.length()) / 2;
        accum += String.format("%s%s\n", " ".repeat(padding), header);

        accum += " Su  Mo  Tu  We  Th  Fr  Sa";

        final int startsAt = this.firstWeekdayOfMonth(month) - 1; // Make sure sunday has index 0
        final int days = DateYMD.monthDays(month, this.year);

        for (int i = 0; i <= days + startsAt; i++) {
            int day = i - startsAt;

            if (day < 1) {
                accum += "   ";
            } else {
                String indicator = this.events[month - 1][day - 1] > 0 ? "*" : " ";
                accum += String.format("%s%2d", indicator, day);
            }

            if (day == days)
                break;

            if (i % DAYS_IN_WEEK == 0)
                accum += "\n";
            else
                accum += " ";
        }

        accum += "\n";

        return accum;
    }

    @Override
    public String toString() {
        String accum = "";
        for (int i = 1; i <= DateYMD.MONTHS_IN_YEAR; i++) {
            accum += printMonth(i);
            if (i != DateYMD.MONTHS_IN_YEAR)
                accum += "\n";
        }
        return accum;
    }
}
