package POO2122Teste;

public class Culture extends Activity {
    public enum Option {
        ARCHITECTURAL_TOUR,
        RIVER_TOUR,
        ART_MUSEUM,
        WINE_TASTING,
    }

    private Option option;

    public Culture(Option option, int maxParticipants) {
        super(maxParticipants);
        this.option = option;
    }

    @Override
    public double getPrice() {
        return 22;
    }

    @Override
    public boolean canCoexist(Activity other) {
        if (other instanceof Culture otherCulture)
            return this.option != otherCulture.option;

        return true;
    }

    private String optionToString() {
        return switch (this.option) {
            case ARCHITECTURAL_TOUR -> "Architectural tour";
            case RIVER_TOUR -> "River tour";
            case ART_MUSEUM -> "Art museum";
            case WINE_TASTING -> "Wine tasting";
        };
    }

    @Override
    public String toString() {
        return String.format("%s with %d participants", this.optionToString(), this.getMaxParticipants());
    }
}
