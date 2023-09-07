package aula11;

public class Time {
    private int hours;
    private int minutes;

    public Time(int hours, int minutes) {
        setHours(hours);
        setMinutes(minutes);
    }

    public int getHours() {
        return hours;
    }

    public int getMinutes() {
        return minutes;
    }

    public void setHours(int hours) {
        if (hours < 0 || hours > 23)
            throw new IllegalArgumentException("As horas têm de estar entre 0 e 23");

        this.hours = hours;
    }

    public void setMinutes(int minutes) {
        if (minutes < 0 || minutes > 59)
            throw new IllegalArgumentException("Os minutos têm de estar entre 0 e 59");

        this.minutes = minutes;
    }

    public Time add(Time other) {
        int minutes = (this.minutes + other.minutes) % 60;
        int hours = this.hours + other.hours +
                (this.minutes + other.minutes) / 60;

        return new Time(hours, minutes);
    }

    public static Time parseTime(String string) {
        String[] parts = string.split(":");

        if (parts.length != 2)
            throw new IllegalArgumentException("A string de tempo deve estar no formato hh:mm");

        int hours = Integer.parseInt(parts[0]);
        int minutes = Integer.parseInt(parts[1]);

        return new Time(hours, minutes);
    }

    @Override
    public String toString() {
        return String.format("%02d:%02d", this.hours, this.minutes);
    }
}
