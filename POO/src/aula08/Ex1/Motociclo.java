package aula08.Ex1;

import java.util.Objects;

public class Motociclo extends Viatura {
    private TipoMotociclo tipo;

    public Motociclo(String matricula, String marca, String modelo, int potencia, TipoMotociclo tipo) {
        super(matricula, marca, modelo, potencia);

        if (tipo == null)
            throw new IllegalArgumentException("O tipo não pode ser nulo");

        this.tipo = tipo;
    }

    public TipoMotociclo getTipo() {
        return tipo;
    }

    @Override
    public String toString() {
        return "Motociclo; " + super.toString() + "; Tipo: " + this.tipo.toString();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Motociclo motociclo = (Motociclo) o;
        return tipo == motociclo.tipo;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), tipo);
    }
}
