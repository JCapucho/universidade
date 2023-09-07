package aula08.Ex1;

import java.util.Objects;

public class Ligeiro extends Automovel {
    private double capacidadeBagageira;

    public Ligeiro(String matricula, String marca, String modelo, int potencia, String vin,
                   double capacidadeBagageira) {
        super(matricula, marca, modelo, potencia, vin);

        if (capacidadeBagageira <= 0)
            throw new IllegalArgumentException("A capacidade da bagageira têm que ser positiva");

        this.capacidadeBagageira = capacidadeBagageira;
    }

    public double getCapacidadeBagageira() {
        return capacidadeBagageira;
    }

    @Override
    public String toString() {
        return "Ligeiro; " + super.toString() + "; Capacidade Bagageira: " + this.capacidadeBagageira;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Ligeiro ligeiro = (Ligeiro) o;
        return Double.compare(ligeiro.capacidadeBagageira, capacidadeBagageira) == 0;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), capacidadeBagageira);
    }
}
