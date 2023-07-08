package teste2;

import java.util.Objects;

public class Package {
    private static int nextID = 0;
    final private int id;
    private double weight;
    private String destination;
    private String sender;

    public Package(double weight, String destination, String sender) {
        this.id = nextID++;
        this.setWeight(weight);
        this.setDestination(destination);
        this.setSender(sender);
    }

    public int getId() {
        return id;
    }

    public double getWeight() {
        return weight;
    }

    public String getDestination() {
        return destination;
    }

    public String getSender() {
        return sender;
    }

    public void setWeight(double weight) {
        if (weight <= 0)
            throw new IllegalArgumentException("The weight must be positive");

        this.weight = weight;
    }

    public void setDestination(String destination) {
        if (destination == null || destination.isEmpty())
            throw new IllegalArgumentException("The destination cannot be null");

        this.destination = destination;
    }

    public void setSender(String sender) {
        if (sender == null || sender.isEmpty())
            throw new IllegalArgumentException("The sender cannot be null");

        this.sender = sender;
    }

    @Override
    public String toString() {
        return String.format("%d: weight: %.2f; destination: %s; sender: %s",
                this.id, this.weight, this.destination, this.sender);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Package aPackage = (Package) o;
        return id == aPackage.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
