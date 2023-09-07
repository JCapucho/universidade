package aula11;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

public class EnergyUsageReport {
    final Map<Integer, Customer> customers = new TreeMap<>();

    public void load(String path) throws FileNotFoundException {
        final Scanner input = new Scanner(new FileReader(path));

        input.useDelimiter("(\\||[\\r\\n]+)");

        while (input.hasNext()) {
            int id = input.nextInt();
            double leitura1 = input.nextDouble();
            double leitura2 = input.nextDouble();
            double leitura3 = input.nextDouble();
            double leitura4 = input.nextDouble();

            List<Double> leituras = Arrays.asList(leitura1, leitura2, leitura3, leitura4);
            customers.put(id, new Customer(id, leituras));

            input.nextLine();
        }

        input.close();
    }

    public void addCustomer(Customer customer) {
        customers.put(customer.getCustomerId(), customer);
    }

    public void removeCustomer(int id) {
        customers.remove(id);
    }

    public Customer getCustomer(int id) {
        return customers.get(id);
    }

    public double calculateTotalUsage(int id) {
        Customer customer = getCustomer(id);
        return customerTotalUsage(customer);
    }

    private double customerTotalUsage(Customer customer) {
        double total = 0;
        for (double leitura : customer.getMeterReadings())
            total += leitura;
        return total;
    }

    public void generateReport(String path) throws IOException {
        FileWriter writer = new FileWriter(path);

        for (Customer customer : customers.values())
            writer.write(customer.getCustomerId() + "|" + customerTotalUsage(customer) + "\n");

        writer.close();
    }
}
