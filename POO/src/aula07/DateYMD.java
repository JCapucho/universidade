package aula07;

import java.security.InvalidParameterException;

public class DateYMD extends Date {
    private int day;
    private int month;
    private int year;

    public DateYMD(int day, int month, int year) {
        set(day, month, year);
    }

    @Override
    public int getDay() {
        return this.day;
    }

    @Override
    public int getMonth() {
        return this.month;
    }

    @Override
    public int getYear() {
        return this.year;
    }

    @Override
    public void set(int day, int month, int year) throws IllegalArgumentException {
        if (!valid(day, month, year))
            throw new InvalidParameterException("A data não é valida");

        this.day = day;
        this.month = month;
        this.year = year;
    }
}
