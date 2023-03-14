package aula04;

import java.util.ArrayList;

class Product {
    private String name;
    private double price;
    private int quantity;

    public Product(String name, double price, int quantity) {
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    public double getTotalValue() {
        return price * quantity;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }
}


class CashRegister {
    private ArrayList<Product> products = new ArrayList();

    public void addProduct(Product pr) {
        products.add(pr);
    }

    @Override
    public String toString() {
        double total = 0;
        String result = "Product        Price       Quantity        Total\n";
        for (Product pr : products) {
            result += String.format("%-14s %5.2f %14d %12.2f\n", pr.getName(), pr.getPrice(), pr.getQuantity(), pr.getTotalValue());
            total += pr.getTotalValue();
        }
        result += String.format("\nTotal value: %.2f", total);
        return result;
    }
}

public class CashRegisterDemo {

    public static void main(String[] args) {

        // Cria e adiciona 5 produtos
        CashRegister cr = new CashRegister();
        cr.addProduct(new Product("Book", 9.99, 3));
        cr.addProduct(new Product("Pen", 1.99, 10));
        cr.addProduct(new Product("Headphones", 29.99, 2));
        cr.addProduct(new Product("Notebook", 19.99, 5));
        cr.addProduct(new Product("Phone case", 5.99, 1));

        System.out.println(cr);
    }
}