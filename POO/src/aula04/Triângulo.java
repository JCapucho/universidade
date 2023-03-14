package aula04;

import java.util.Objects;

class Triângulo implements Figura {
    double lado1, lado2, lado3;

    public Triângulo(double lado1, double lado2, double lado3) {
        assert lado1 > 0 && lado2 > 0 && lado3 > 0;
        assert lado1 <= lado2 + lado3;
        assert lado2 <= lado1 + lado3;
        assert lado3 <= lado1 + lado2;

        this.lado1 = lado1;
        this.lado2 = lado2;
        this.lado3 = lado3;
    }

    public double getLado1() {
        return lado1;
    }

    public void setLado1(double lado1) {
        assert lado1 > 0;
        assert lado1 <= this.lado2 + this.lado3;

        this.lado1 = lado1;
    }

    public double getLado2() {
        return lado2;
    }

    public void setLado2(double lado2) {
        assert lado2 > 0;
        assert lado2 <= this.lado1 + this.lado3;

        this.lado2 = lado2;
    }

    public double getLado3() {
        return lado3;
    }

    public void setLado3(double lado3) {
        assert lado3 > 0;
        assert lado3 <= this.lado1 + this.lado2;

        this.lado3 = lado3;
    }

    public double area() {
        double p = this.perimetro() / 2;
        return Math.sqrt(p * (p - this.lado1) * (p - this.lado2) * (p - this.lado3));
    }

    public double perimetro() {
        return this.lado1 + this.lado2 + this.lado3;
    }

    @Override
    public String toString() {
        return "Triângulo{" +
                "lado1=" + lado1 +
                ", lado2=" + lado2 +
                ", lado3=" + lado3 +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Triângulo triângulo = (Triângulo) o;

        return triângulo.lado1 == this.lado1 && triângulo.lado2 == this.lado2 && triângulo.lado3 == this.lado3;
    }

    @Override
    public int hashCode() {
        return Objects.hash(lado1, lado2, lado3);
    }
}
