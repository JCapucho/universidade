package POO2122Teste;

public abstract class Activity {
    private int maxParticipants;

    public Activity(int maxParticipants) {
        this.setMaxParticipants(maxParticipants);
    }

    public int getMaxParticipants() {
        return maxParticipants;
    }

    public void setMaxParticipants(int maxParticipants) {
        if (maxParticipants <= 0)
            throw new IllegalArgumentException("O número máximo de participantes tem de ser positivo");

        this.maxParticipants = maxParticipants;
    }

    public abstract double getPrice();

    public boolean canCoexist(Activity other) {
        return true;
    }
}
