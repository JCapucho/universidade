package aula08.Ex2;

import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Vector;

public class Prato implements Comparable<Prato> {

    private String nome;
    private Vector<Alimento> alimentos = new Vector<>();
    private double preco;

    public Prato(String nome) {
        this.setNome(nome);
    }

    public Prato(String nome, double preco) {
        this(nome);
        this.setPreco(preco);
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        if (nome == null || nome.length() == 0)
            throw new IllegalArgumentException("O nome não pode ser nulo");

        this.nome = nome;
    }

    public double getPreco() {
        return this.preco;
    }

    public void setPreco(double preco) {
        if (preco < 0)
            throw new IllegalArgumentException("O preço não pode ser negativo");

        this.preco = preco;
    }

    public boolean addIngrediente(Alimento alim) {
        alimentos.add(alim);
        return true;
    }

    public void removerIngrediente(int idx) {
        alimentos.remove(idx);
    }

    public void removerIngrediente(Alimento alim) {
        alimentos.remove(alim);
    }

    public List<Alimento> alimentos() {
        return Collections.unmodifiableList(this.alimentos);
    }

    public double totalPeso() {
        double peso = 0.0;

        for (Alimento alim : alimentos) peso += alim.getPeso();

        return peso;
    }

    public double totalCalorias() {
        double calorias = 0.0;

        for (Alimento alim : alimentos) calorias += alim.getCalorias();

        return calorias;
    }

    public double totalProteinas() {
        double proteinas = 0.0;

        for (Alimento alim : alimentos) proteinas += alim.getCalorias();

        return proteinas;
    }

    @Override
    public String toString() {
        return String.format("Prato '%s', composto por %d Ingredientes", this.nome, this.alimentos.size());
    }

    @Override
    public int compareTo(Prato p) {
        if (totalCalorias() < p.totalCalorias())
            return -1;
        else if (totalCalorias() > p.totalCalorias())
            return 1;
        return 0;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Prato prato = (Prato) o;
        return Double.compare(prato.preco, preco) == 0 && Objects.equals(nome, prato.nome) && Objects.equals(alimentos, prato.alimentos);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nome, alimentos, preco);
    }
}
