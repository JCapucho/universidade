package aula07;

class Círculo extends Forma {
    private double raio;

    public Círculo(String cor, double raio) {
        super(cor);
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
                "cor=" + this.getCor() +
                ", raio=" + this.raio +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Círculo círculo = (Círculo) o;

        return super.equals(o) && círculo.raio == this.raio;
    }

    @Override
    public int hashCode() {
        return Double.hashCode(raio);
    }
}
