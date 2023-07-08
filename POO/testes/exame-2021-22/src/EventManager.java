package POO2122Teste;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

public class EventManager {
    private String name;
    private Map<Client, List<Event>> clients = new HashMap<>();

    public EventManager(String name) {
        this.name = name;
    }

    public Client addClient(String name, String location) {
        Client client = new Client(name, location);
        this.clients.put(client, new Vector<>());
        return client;
    }

    public Event addEvent(Client client, LocalDate date) {
        Event event = new Event(date);
        this.clients.get(client).add(event);
        return event;
    }

    public String listClients() {
        StringBuilder builder = new StringBuilder();

        builder.append("Clients:");

        for (Client client : clients.keySet())
            builder.append("\n").append(client);

        return builder.toString();
    }

    public String listEvents() {
        StringBuilder builder = new StringBuilder();

        builder.append("Events:");

        for (Map.Entry<Client, List<Event>> entry : clients.entrySet()) {
            builder.append("\n").append(entry.getKey()).append("\n");

            for (Event event : entry.getValue())
                builder.append(event);
        }

        return builder.toString();
    }
}
