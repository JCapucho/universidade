package aula07;

import aula05.DateYMD;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class DateND extends Date {
    private static final LocalDate EPOCH = LocalDate.of(2000, 1, 1);

    public long distance;

    public DateND(long distance) {
        this.distance = distance;
    }

    private DateYMD toDateYMD() {
        LocalDate localDate = asLocalDate();
        DateYMD date = new DateYMD(localDate.getDayOfMonth(), localDate.getMonthValue(), localDate.getYear());

        return date;
    }

    public LocalDate asLocalDate() {
        return EPOCH.plusDays(this.distance);
    }

    @Override
    public int getDay() {
        return asLocalDate().getDayOfMonth();
    }

    @Override
    public int getMonth() {
        return asLocalDate().getMonthValue();
    }

    @Override
    public int getYear() {
        return asLocalDate().getYear();
    }

    @Override
    public void set(int day, int month, int year) throws IllegalArgumentException {
        LocalDate datenow = LocalDate.of(year, month, day);
        this.distance = ChronoUnit.DAYS.between(EPOCH, datenow);
    }
}
