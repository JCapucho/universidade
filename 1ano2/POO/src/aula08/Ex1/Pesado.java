package aula08.Ex1;

import java.util.Objects;

public abstract class Pesado extends Automovel {
    private int peso;

    public Pesado(String matricula, String marca, String modelo, int potencia, String vin, int peso) {
        super(matricula, marca, modelo, potencia, vin);

        this.peso = peso;
    }

    public int getPeso() {
        return peso;
    }

    @Override
    public String toString() {
        return "Motociclo; " + super.toString() + "; Peso: " + this.peso;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Pesado pesado = (Pesado) o;
        return peso == pesado.peso;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), peso);
    }
}
