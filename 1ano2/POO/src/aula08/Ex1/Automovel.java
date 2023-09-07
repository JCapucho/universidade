package aula08.Ex1;

import java.util.Objects;

public abstract class Automovel extends Viatura {
    private String vin;

    public Automovel(String matricula, String marca, String modelo, int potencia, String vin) {
        super(matricula, marca, modelo, potencia);

        if (!validVin(vin))
            throw new IllegalArgumentException("Vin inválido");

        this.vin = vin;
    }

    public String getVin() {
        return vin;
    }

    public static boolean validVin(String vin) {
        return vin != null && vin.matches("^[A-Z0-9]{17}$");
    }

    @Override
    public String toString() {
        return super.toString() + "; Número do quadro: " + this.vin;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        Automovel automovel = (Automovel) o;
        return Objects.equals(vin, automovel.vin);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), vin);
    }
}
