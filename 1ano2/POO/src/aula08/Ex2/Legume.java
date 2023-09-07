package aula08.Ex2;

import java.util.Objects;

public class Legume extends AlimentoVegetariano {
    private String nome;

    public Legume(String nome, double proteinas, double calorias, double peso) {
        super(proteinas, calorias, peso);
        this.setNome(nome);
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        if (nome == null || nome.length() == 0)
            throw new IllegalArgumentException("O nome não pode ser nulo");

        this.nome = nome;
    }

    @Override
    public String toString() {
        return String.format("Legume %s, %s", this.nome, super.toString());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Legume legume = (Legume) o;
        return Objects.equals(nome, legume.nome);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), nome);
    }
}
