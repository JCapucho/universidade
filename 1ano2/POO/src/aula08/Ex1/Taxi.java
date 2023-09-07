package aula08.Ex1;

import java.util.Objects;

public class Taxi extends Ligeiro {
    public int licenca;

    public Taxi(String matricula, String marca, String modelo, int potencia, String vin, double capacidadeBagageira,
                int licenca) {
        super(matricula, marca, modelo, potencia, vin, capacidadeBagageira);

        if (licenca < 0)
            throw new IllegalArgumentException("A licença não pode ser menor que 0");

        this.licenca = licenca;
    }

    public int getLicenca() {
        return licenca;
    }

    @Override
    public String toString() {
        return "Taxi-" + super.toString() + "; Número de licença: " + this.licenca;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Taxi taxi = (Taxi) o;
        return licenca == taxi.licenca;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), licenca);
    }
}
