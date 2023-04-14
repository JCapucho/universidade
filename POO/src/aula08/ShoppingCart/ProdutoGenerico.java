package aula08.ShoppingCart;

import java.util.Objects;

public class ProdutoGenerico implements Produto {
    private String nome;
    private double preco;
    private int quantidade;

    public ProdutoGenerico(String nome, int quantidade, double preco) {
        this.nome = nome;
        this.quantidade = quantidade;
        this.preco = preco;
    }

    @Override
    public String getNome() {
        return this.nome;
    }

    @Override
    public double getPreco() {
        return this.preco;
    }

    @Override
    public int getQuantidade() {
        return this.quantidade;
    }

    @Override
    public void adicionarQuantidade(int quantidade) {
        this.quantidade += quantidade;
    }

    @Override
    public void removerQuantidade(int quantidade) {
        this.quantidade -= quantidade;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProdutoGenerico that = (ProdutoGenerico) o;
        return Objects.equals(nome, that.nome);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nome);
    }

    @Override
    public String toString() {
        return String.format("%s; Preço: %.2f; Em stock: %d", this.nome, this.preco, this.quantidade);
    }
}
