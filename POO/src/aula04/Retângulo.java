package aula04;

import java.util.Objects;

class Retângulo implements Figura {
    double comprimento, altura;

    public Retângulo(double comprimento, double altura) {
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
                "comprimento=" + comprimento +
                ", altura=" + altura +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Retângulo retângulo = (Retângulo) o;
        return retângulo.comprimento == this.comprimento && retângulo.altura == this.altura;
    }

    @Override
    public int hashCode() {
        return Objects.hash(comprimento, altura);
    }
}
