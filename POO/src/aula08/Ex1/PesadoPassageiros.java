package aula08.Ex1;

import java.util.Objects;

public class PesadoPassageiros extends Pesado {
    private int capacidadePassageiros;

    public PesadoPassageiros(String matricula, String marca, String modelo, int potencia, String vin, int peso,
                             int capacidadePassageiros) {
        super(matricula, marca, modelo, potencia, vin, peso);

        if (capacidadePassageiros <= 8)
            throw new IllegalArgumentException("A capacidade de passageiros têm de ser maior que 8");

        this.capacidadePassageiros = capacidadePassageiros;
    }

    public int getCapacidadePassageiros() {
        return capacidadePassageiros;
    }

    @Override
    public String toString() {
        return "Pesado Passageiros; " + super.toString() + "; Capacidade Passageiros: " + this.capacidadePassageiros;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        PesadoPassageiros that = (PesadoPassageiros) o;
        return capacidadePassageiros == that.capacidadePassageiros;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), capacidadePassageiros);
    }
}
