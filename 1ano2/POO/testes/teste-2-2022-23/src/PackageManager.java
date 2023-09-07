package teste2;

import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class PackageManager {
    final Map<Integer, Package> packages = new HashMap<>();
    final ShippingCostCalculator calculator = new StandardShippingCostCalculator();

    public void addPackage(Package pkg) {
        this.packages.put(pkg.getId(), pkg);
    }

    public void removePackage(int id) {
        this.packages.remove(id);
    }

    public Package searchPackage(int id) {
        return this.packages.get(id);
    }

    public double calculateShippingCost(int id) {
        final Package pkg = this.searchPackage(id);
        return this.calculateShippingCost(pkg);
    }

    public double calculateShippingCost(Package pkg) {
        if (pkg == null)
            return -1;

        return calculator.calculateShippingCost(pkg);
    }

    public Collection<Package> getPackages() {
        return Collections.unmodifiableCollection(this.packages.values());
    }

    public void printAllPackage() {
        for (Package pkg : this.getPackages())
            System.out.println(pkg);
    }
}
