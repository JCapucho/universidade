package aula07;

public abstract class Forma {
    private String cor;

    public Forma(String cor) {
        this.setCor(cor);
    }

    public abstract double area();

    public abstract double perimetro();

    public String getCor() {
        return cor;
    }

    public void setCor(String cor) {
        if (cor == null || cor.length() == 0)
            throw new IllegalArgumentException("A cor não pode ser nula ou vazia");

        this.cor = cor;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        Forma forma = (Forma) obj;

        return forma.cor == this.cor;
    }
}
