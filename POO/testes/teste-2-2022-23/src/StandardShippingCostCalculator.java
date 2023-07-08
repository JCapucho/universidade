package teste2;

public class StandardShippingCostCalculator implements ShippingCostCalculator {
    @Override
    public double calculateShippingCost(Package pkg) {
        final double weight = pkg.getWeight();
        double rate = 3;

        if (weight < 5)
            rate = 1;
        else if (weight <= 10)
            rate = 2;

        return weight * rate;
    }
}
