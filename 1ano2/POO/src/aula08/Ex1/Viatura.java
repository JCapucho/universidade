package aula08.Ex1;

import java.util.Objects;

public abstract class Viatura implements KmPercorridosInterface {
    private String matricula;
    private String marca;
    private String modelo;
    private int potencia;

    private int distanciaPercorrida = 0;
    private int ultimoTrajeto;

    public Viatura(String matricula, String marca, String modelo, int potencia) {
        if (marca == null || marca.length() == 0)
            throw new IllegalArgumentException("A marca não pode ser nula");

        if (modelo == null || modelo.length() == 0)
            throw new IllegalArgumentException("O modelo não pode ser nula");

        this.marca = marca;
        this.modelo = modelo;
        this.setMatricula(matricula);
        this.setPotencia(potencia);
    }

    public String getMatricula() {
        return matricula;
    }

    public String getMarca() {
        return marca;
    }

    public String getModelo() {
        return modelo;
    }

    public int getPotencia() {
        return potencia;
    }

    public void setMatricula(String matricula) {
        if (!validMatricula(matricula))
            throw new IllegalArgumentException("A matrícula não é válida");

        this.matricula = matricula;
    }

    public void setPotencia(int potencia) {
        if (potencia < 1)
            throw new IllegalArgumentException("A potência tem que sair maior que 0");

        this.potencia = potencia;
    }

    @Override
    public void trajeto(int quilometros) {
        this.ultimoTrajeto = quilometros;
        this.distanciaPercorrida += quilometros;
    }

    @Override
    public int ultimoTrajeto() {
        return this.ultimoTrajeto;
    }

    @Override
    public int distanciaTotal() {
        return this.distanciaPercorrida;
    }

    public static boolean validMatricula(String matricula) {
        return matricula != null && matricula.matches("^(([A-Z]{2}-\\d{2}-(\\d{2}|[A-Z]{2}))|(\\d{2}-" +
                "(\\d{2}-[A-Z]{2}|[A-Z]{2}-\\d{2})))$");
    }

    @Override
    public String toString() {
        return String.format("Matrícula: %s; Marca: %s; Modelo: %s; Potência (cv): %d", this.matricula, this.marca,
                this.modelo, this.potencia);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Viatura viatura = (Viatura) o;
        return potencia == viatura.potencia && Objects.equals(matricula, viatura.matricula) && Objects.equals(marca,
                viatura.marca) && Objects.equals(modelo, viatura.modelo);
    }

    @Override
    public int hashCode() {
        return Objects.hash(matricula, marca, modelo, potencia);
    }
}
