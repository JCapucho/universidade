package POO2122Teste;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Vector;

public class Event implements IEvent {
    private LocalDate date;
    private Vector<Activity> activities = new Vector<>();

    public Event(LocalDate date) {
        this.date = date;
    }

    @Override
    public Event addActivity(Activity activity) {
        for (Activity otherActivity : activities) {
            if (!activity.canCoexist(otherActivity))
                return this;
        }

        activities.add(activity);

        return this;
    }

    @Override
    public LocalDate getDate() {
        return this.date;
    }

    @Override
    public double totalPrice() {
        return activities.stream().mapToDouble(Activity::getPrice).sum();
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();

        builder.append(String.format("*** Evento em %s, total=%.0f euros", this.date, this.totalPrice()));

        for (Activity activity : activities)
            builder.append("\n\t").append(activity).append(".");

        return builder.toString();
    }
}
