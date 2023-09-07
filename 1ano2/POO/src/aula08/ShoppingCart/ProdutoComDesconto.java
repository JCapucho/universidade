package aula08.ShoppingCart;

public class ProdutoComDesconto extends ProdutoGenerico {
    private int desconto;

    public ProdutoComDesconto(String nome, int quantidade, double preco, int desconto) {
        super(nome, quantidade, preco);

        this.desconto = desconto;
    }

    @Override
    public double getPreco() {
        return super.getPreco() / this.desconto;
    }

    @Override
    public String toString() {
        return super.toString() + " (Desconto " + this.desconto + "%)";
    }
}
