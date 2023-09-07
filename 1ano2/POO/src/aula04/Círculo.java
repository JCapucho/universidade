package aula04;

class Círculo implements Figura {
    private double raio;

    public Círculo(double raio) {
        this.setRaio(raio);
    }

    public double getRaio() {
        return raio;
    }

    public void setRaio(double raio) {
        assert raio > 0;
        this.raio = raio;
    }

    public double area() {
        return Math.PI * this.raio * this.raio;
    }

    public double perimetro() {
        return 2 * Math.PI * this.raio;
    }

    @Override
    public String toString() {
        return "Círculo{" +
                "raio=" + raio +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Círculo círculo = (Círculo) o;

        return círculo.raio == this.raio;
    }

    @Override
    public int hashCode() {
        return Double.hashCode(raio);
    }
}
