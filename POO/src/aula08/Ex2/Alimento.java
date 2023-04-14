package aula08.Ex2;

import java.util.Objects;

public abstract class Alimento {
    private double proteinas;
    private double calorias;
    private double peso;


    public Alimento(double proteinas, double calorias, double peso) {
        this.setProteinas(proteinas);
        this.setCalorias(calorias);
        this.setPeso(peso);
    }

    public double getProteinas() {
        return proteinas;
    }

    public void setProteinas(double proteinas) {
        if (proteinas < 0)
            throw new IllegalArgumentException("As proteínas não podem ser negativas");

        this.proteinas = proteinas;
    }

    public double getCalorias() {
        return calorias;
    }

    public void setCalorias(double calorias) {
        if (calorias < 0)
            throw new IllegalArgumentException("As calorias não podem ser negativas");

        this.calorias = calorias;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        if (peso <= 0)
            throw new IllegalArgumentException("O peso têm que ser positivo");

        this.peso = peso;
    }

    @Override
    public String toString() {
        return String.format("Proteinas %.1f, calorias %.1f, Peso %.1f", this.proteinas, this.calorias, this.peso);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Alimento alimento = (Alimento) o;
        return Double.compare(alimento.proteinas, proteinas) == 0 && Double.compare(alimento.calorias, calorias) == 0 && Double.compare(alimento.peso, peso) == 0;
    }

    @Override
    public int hashCode() {
        return Objects.hash(proteinas, calorias, peso);
    }
}
