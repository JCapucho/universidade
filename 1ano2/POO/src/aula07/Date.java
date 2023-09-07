package aula07;

import java.util.Objects;

public abstract class Date implements Comparable<Date> {
    public static final int MONTHS_IN_YEAR = 12;
    public static final int MAX_DAYS_IN_MONTH = 31;

    public abstract int getDay();

    public abstract int getMonth();

    public abstract int getYear();

    public abstract void set(int day, int month, int year) throws IllegalArgumentException;

    public void setDay(int day) {
        this.set(day, getMonth(), getYear());
    }

    public void setMonth(int month) {
        this.set(getDay(), month, getYear());
    }

    public void setYear(int year) {
        this.set(getDay(), getMonth(), year);
    }

    public void increment() {
        int day = getDay();
        int month = getMonth();
        int year = getYear();

        day += 1;

        if (day > monthDays(month, year)) {
            day = 1;
            month += 1;

            if (month > MONTHS_IN_YEAR) {
                month = 1;
                year += 1;
            }
        }

        set(day, month, year);
    }

    public void decrement() {
        int day = getDay();
        int month = getMonth();
        int year = getYear();

        day -= 1;

        if (day < 1) {
            month -= 1;

            if (month < 1) {
                year -= 1;
                month = MONTHS_IN_YEAR;
            }

            day = monthDays(month, year);
        }

        set(day, month, year);
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
        return String.format("%04d-%02d-%02d", getYear(), getMonth(), getDay());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Date date = (Date) o;
        return this.getDay() == date.getDay() && this.getMonth() == date.getMonth() && this.getYear() == date.getYear();
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.getDay(), this.getMonth(), this.getYear());
    }

    @Override
    public int compareTo(Date o) {
        if (this.getYear() > o.getYear())
            return 1;
        if (this.getYear() < o.getYear())
            return -1;

        if (this.getMonth() > o.getMonth())
            return 1;
        if (this.getMonth() < o.getMonth())
            return -1;

        if (this.getDay() > o.getDay())
            return 1;
        if (this.getDay() < o.getDay())
            return -1;

        return 0;
    }
}
