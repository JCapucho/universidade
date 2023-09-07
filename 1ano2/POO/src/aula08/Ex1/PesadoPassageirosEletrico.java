package aula08.Ex1;

import java.util.Objects;

public class PesadoPassageirosEletrico extends PesadoPassageiros implements VeiculoEletrico {
    private int carga;
    private int autonomiaMaxima;

    public PesadoPassageirosEletrico(String matricula, String marca, String modelo, int potencia, String vin,
                                     int peso, int capacidadePassageiros, int carga, int autonomiaMaxima) {
        super(matricula, marca, modelo, potencia, vin, peso, capacidadePassageiros);

        this.carregar(carga);
        this.setAutonomiaMaxima(autonomiaMaxima);
    }

    public int getCarga() {
        return carga;
    }

    public int getAutonomiaMaxima() {
        return autonomiaMaxima;
    }

    public void setAutonomiaMaxima(int autonomiaMaxima) {
        if (autonomiaMaxima <= 0)
            throw new IllegalArgumentException("A autonomia máxima têm que ser positiva");

        this.autonomiaMaxima = autonomiaMaxima;
    }

    @Override
    public void trajeto(int quilometros) {
        int cargaNecessaria = (int) ((double) quilometros / (double) autonomiaMaxima * 100);

        if (cargaNecessaria > this.carga)
            throw new RuntimeException("Sem carga suficiente para completar trajeto");

        this.carga -= cargaNecessaria;

        super.trajeto(quilometros);
    }

    @Override
    public int autonomia() {
        return this.autonomiaMaxima / this.carga;
    }

    @Override
    public void carregar(int percentagem) {
        if (percentagem < 0 || percentagem > 100)
            throw new IllegalArgumentException("Uma percentagem têm que estar entre 0 e 100");

        this.carga = percentagem;
    }

    @Override
    public String toString() {
        return "(Elétrico) " + super.toString() + "; Autonomia (Máxima): " + this.autonomiaMaxima + "; Carga: " + this.carga;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        PesadoPassageirosEletrico that = (PesadoPassageirosEletrico) o;
        return carga == that.carga && autonomiaMaxima == that.autonomiaMaxima;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), carga, autonomiaMaxima);
    }
}
