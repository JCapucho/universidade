package aula08.ShoppingCart;


import java.util.HashMap;
import java.util.Map;

public class CarrinhoDeCompras implements Compra {
    private HashMap<Produto, Integer> compras = new HashMap<>();

    @Override
    public void adicionarProduto(Produto produto, int quantidade) {
        this.compras.put(produto, quantidade);
    }

    @Override
    public void listarProdutos() {
        for (Map.Entry<Produto, Integer> compra : this.compras.entrySet()) {
            System.out.printf("%dx %s\n", compra.getValue(), compra.getKey());
        }
    }

    @Override
    public double calcularTotal() {
        double total = 0;

        for (Map.Entry<Produto, Integer> compra : this.compras.entrySet()) {
            total += compra.getKey().getPreco() * compra.getValue();
        }

        return total;
    }
}
