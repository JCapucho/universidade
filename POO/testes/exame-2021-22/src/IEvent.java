package POO2122Teste;

import java.time.LocalDate;

public interface IEvent {
    Event addActivity(Activity activity);

    LocalDate getDate();

    double totalPrice();
}
