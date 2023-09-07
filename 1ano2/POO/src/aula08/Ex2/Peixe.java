package aula08.Ex2;

import java.util.Objects;

public class Peixe extends Alimento {
    private TipoPeixe tipo;

    public Peixe(TipoPeixe tipo, double proteinas, double calorias, double peso) {
        super(proteinas, calorias, peso);
        this.setTipo(tipo);
    }

    public TipoPeixe getTipo() {
        return tipo;
    }

    public void setTipo(TipoPeixe tipo) {
        if (tipo == null)
            throw new IllegalArgumentException("O tipo não pode ser nulo");

        this.tipo = tipo;
    }

    @Override
    public String toString() {
        return String.format("Peixe %s, %s", this.tipo, super.toString());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Peixe peixe = (Peixe) o;
        return tipo == peixe.tipo;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), tipo);
    }
}
