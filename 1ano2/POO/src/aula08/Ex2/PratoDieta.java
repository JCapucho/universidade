package aula08.Ex2;

import utils.Random;

import java.util.Objects;

public class PratoDieta extends Prato {
    private double limiteCalorias;

    public PratoDieta(String nome, double preco) {
        super(nome, preco);
        this.limiteCalorias = Random.randomDoubleRange(50, 100);
    }

    public PratoDieta(String nome, double preco, double limiteCalorias) {
        super(nome, preco);
        this.setLimiteCalorias(limiteCalorias);
    }

    public double getLimiteCalorias() {
        return limiteCalorias;
    }

    public void setLimiteCalorias(double limiteCalorias) {
        if (limiteCalorias < 0)
            throw new IllegalArgumentException("O limite de calorias não pode ser negativo");

        this.limiteCalorias = limiteCalorias;
    }

    @Override
    public boolean addIngrediente(Alimento alim) {
        if (totalCalorias() + alim.getCalorias() <= limiteCalorias)
            return super.addIngrediente(alim);
        return false;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        PratoDieta that = (PratoDieta) o;
        return Double.compare(that.limiteCalorias, limiteCalorias) == 0;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), limiteCalorias);
    }

    @Override
    public String toString() {
        return String.format("%s - Dieta (%.2f Calorias)", super.toString(), this.limiteCalorias);
    }
}
