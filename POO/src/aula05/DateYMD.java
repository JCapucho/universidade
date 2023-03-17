package aula05;

import java.security.InvalidParameterException;

public class DateYMD {
    public static final int MONTHS_IN_YEAR = 12;
    public static final int MAX_DAYS_IN_MONTH = 31;

    private int day;
    private int month;
    private int year;

    public DateYMD(int day, int month, int year) {
        set(day, month, year);
    }

    public void set(int day, int month, int year) throws InvalidParameterException {
        if (!valid(day, month, year))
            throw new InvalidParameterException("A data não é valida");

        this.day = day;
        this.month = month;
        this.year = year;
    }

    public int getDay() {
        return day;
    }

    public int getMonth() {
        return month;
    }

    public int getYear() {
        return year;
    }

    public void increment() {
        day += 1;

        if (day > monthDays(this.month, this.year)) {
            day = 1;
            month += 1;

            if (month > MONTHS_IN_YEAR) {
                month = 1;
                year += 1;
            }
        }
    }

    public void decrement() {
        day -= 1;

        if (day < 1) {
            month -= 1;

            if (month < 1) {
                year -= 1;
                month = MONTHS_IN_YEAR;
            }

            day = monthDays(month, year);
        }
    }

    @Override
    protected DateYMD clone() {
        return new DateYMD(day, month, year);
    }

    public static boolean validMonth(int month) {
        return month >= 1 && month <= MONTHS_IN_YEAR;
    }

    public static boolean leapYear(int year) {
        return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
    }

    public static int monthDays(int month, int year) {
        final int[] daysInMonth = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

        if (month == 2 && leapYear(year))
            return 29;

        return daysInMonth[month - 1];
    }

    public static boolean valid(int day, int month, int year) {
        if (!validMonth(month))
            return false;

        return day >= 1 && day <= monthDays(month, year);
    }

    @Override
    public String toString() {
        return String.format("%04d-%02d-%02d", year, month, day);
    }
}
