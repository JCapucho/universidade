package teste2;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;
import java.util.Scanner;

public class PackagingTester {
    public static void main(String[] args) {
        final Random rng = new Random();
        final PackageManager manager = new PackageManager();

        for (int i = 0; i < 5; i++) {
            final double weight = rng.nextDouble() * 20;
            final Package pkg = new Package(weight, "Aveiro, Portugal", "DETI, UA");
            manager.addPackage(pkg);
        }

        final Package test_pkg = new Package(34, "Lisboa, Portugal", "Aveiro, Portugal");
        manager.addPackage(test_pkg);

        manager.removePackage(test_pkg.getId());

        try (Scanner input = new Scanner(new FileReader("encomendas.txt"))) {
            input.useDelimiter("(;|[\\r\\n]+)\\s*");
            // Skip header
            input.nextLine();

            while (input.hasNextLine()) {
                // Skip ID
                input.nextInt();
                final double weight = input.nextDouble();
                final String destination = input.next();
                final String sender = input.next();

                final Package pkg = new Package(weight, destination, sender);
                manager.addPackage(pkg);

                input.nextLine();
            }
        } catch (IOException e) {
            System.err.println("Failed to read encomendas file");
        }

        final Package search_pkg = manager.searchPackage(10);
        System.out.println("searchPackage(10): " + search_pkg);

        manager.printAllPackage();

        final double search_pkg_cost = manager.calculateShippingCost(10);
        System.out.println("Package 10 cost: " + search_pkg_cost);

        try (FileWriter output = new FileWriter("encomendas-out.txt")) {
            output.write("SENDER; DESTINATION; WEIGHT; PRICE\n");

            for (Package pkg : manager.getPackages()) {
                final double cost = manager.calculateShippingCost(pkg.getId());

                output.write(pkg.getSender());
                output.write("; " + pkg.getDestination());
                output.write(String.format("; %.2f", pkg.getWeight()));
                output.write(String.format("; %.2f\n", cost));
            }
        } catch (IOException e) {
            System.err.println("Failed to write encomendas-out file");
        }
    }
}
