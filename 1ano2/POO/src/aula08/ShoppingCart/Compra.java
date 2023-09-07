package aula08.ShoppingCart;

public interface Compra {
    void adicionarProduto(Produto produto, int quantidade);

    void listarProdutos();

    double calcularTotal();
}
