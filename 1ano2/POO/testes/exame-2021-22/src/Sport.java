package POO2122Teste;

public class Sport extends Activity {
    public enum Modality {
        KAYAK,
        BIKE
    }

    private Modality modality;

    public Sport(Modality modality, int maxParticipants) {
        super(maxParticipants);
        this.modality = modality;
    }

    @Override
    public double getPrice() {
        return 30;
    }

    @Override
    public boolean canCoexist(Activity other) {
        if (other instanceof Sport otherSport)
            return this.modality != otherSport.modality;

        return true;
    }


    private String modalityToString() {
        return switch (this.modality) {
            case KAYAK -> "Kayak";
            case BIKE -> "Bike";
        };
    }

    @Override
    public String toString() {
        return String.format("%s sporting activity with %d participants", this.modalityToString(),
                this.getMaxParticipants());
    }
}
