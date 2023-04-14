package aula08.Ex1;

import java.util.Objects;

public class PesadoMercadorias extends Pesado {
    private int cargaMaxima;

    public PesadoMercadorias(String matricula, String marca, String modelo, int potencia, String vin, int peso,
                             int cargaMaxima) {
        super(matricula, marca, modelo, potencia, vin, peso);

        if (this.getPeso() < 3500)
            throw new IllegalArgumentException("Um pesado têm de ter pelo menos 3500 kg");

        if (cargaMaxima < 0)
            throw new IllegalArgumentException("A carga máxima têm que ser maior que 0");

        this.cargaMaxima = cargaMaxima;
    }

    public int getCargaMaxima() {
        return cargaMaxima;
    }

    @Override
    public String toString() {
        return "Pesado Mercadorias; " + super.toString() + "; Carga Máxima: " + this.cargaMaxima;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        PesadoMercadorias that = (PesadoMercadorias) o;
        return cargaMaxima == that.cargaMaxima;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), cargaMaxima);
    }
}
