package POO2122Teste;

import java.util.Objects;

public class Catering extends Activity {
    public enum Option {
        FULL_MENU,
        DRINKS_AND_SNACKS,
        LIGHT_BITES,
    }

    private Option option;

    public Catering(Option option, int maxParticipants) {
        super(maxParticipants);
        this.option = option;
    }


    @Override
    public double getPrice() {
        return 25;
    }

    @Override
    public boolean canCoexist(Activity other) {
        return !(other instanceof Catering);
    }

    private String optionToString() {
        return switch (this.option) {
            case FULL_MENU -> "Full menu";
            case DRINKS_AND_SNACKS -> "Drinks and Snacks";
            case LIGHT_BITES -> "Light bites";
        };
    }

    @Override
    public String toString() {
        return String.format("'%s' for %d participants", this.optionToString(), this.getMaxParticipants());
    }
}
