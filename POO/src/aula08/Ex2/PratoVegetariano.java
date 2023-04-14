package aula08.Ex2;

public class PratoVegetariano extends Prato {
    public PratoVegetariano(String nome) {
        super(nome);
    }

    public PratoVegetariano(String nome, double preco) {
        super(nome, preco);
    }

    @Override
    public boolean addIngrediente(Alimento a) {
        if (a instanceof AlimentoVegetariano)
            return super.addIngrediente(a);
        return false;
    }

    @Override
    public String toString() {
        return super.toString() + " - Prato Vegetariano";
    }
}
