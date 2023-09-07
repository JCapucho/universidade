package aula07;

import java.util.Objects;

class Retângulo extends Forma {
    double comprimento, altura;

    public Retângulo(String cor, double comprimento, double altura) {
        super(cor);

        this.setAltura(altura);
        this.setComprimento(comprimento);
    }

    public double getComprimento() {
        return comprimento;
    }

    public void setComprimento(double comprimento) {
        assert comprimento > 0;
        this.comprimento = comprimento;
    }

    public double getAltura() {
        return altura;
    }

    public void setAltura(double altura) {
        assert altura > 0;
        this.altura = altura;
    }

    public double area() {
        return this.comprimento * this.altura;
    }

    public double perimetro() {
        return 2 * this.comprimento + 2 * this.altura;
    }

    @Override
    public String toString() {
        return "Retângulo{" +
                "cor=" + this.getCor() +
                ", comprimento=" + this.comprimento +
                ", altura=" + this.altura +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Retângulo retângulo = (Retângulo) o;

        return super.equals(o) && retângulo.comprimento == this.comprimento && retângulo.altura == this.altura;
    }

    @Override
    public int hashCode() {
        return Objects.hash(comprimento, altura);
    }
}
