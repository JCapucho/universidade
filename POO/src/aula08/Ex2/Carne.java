package aula08.Ex2;

import java.util.Objects;

public class Carne extends Alimento {
    private VariedadeCarne variedade;

    public Carne(VariedadeCarne variedade, double proteinas, double calorias, double peso) {
        super(proteinas, calorias, peso);
        this.setVariedade(variedade);
    }

    public VariedadeCarne getVariedade() {
        return variedade;
    }

    public void setVariedade(VariedadeCarne variedade) {
        if (variedade == null)
            throw new IllegalArgumentException("A variedade não pode ser nula");

        this.variedade = variedade;
    }

    @Override
    public String toString() {
        return String.format("Carne %s, %s", this.variedade, super.toString());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Carne carne = (Carne) o;
        return variedade == carne.variedade;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), variedade);
    }
}
