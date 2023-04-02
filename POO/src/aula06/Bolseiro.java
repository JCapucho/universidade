package aula06;

import utils.DateYMD;

public class Bolseiro extends Aluno {
    private Professor orientador;
    private int bolsa;

    public Bolseiro(String iNome, int iBI, DateYMD iDataNasc, Professor orientador, int bolsa) {
        super(iNome, iBI, iDataNasc);

        if (orientador == null)
            throw new IllegalArgumentException("O professor orientador não pode ser nulo");

        if (bolsa <= 0)
            throw new IllegalArgumentException("O valor da bolsa mensal tem que positivo");

        this.orientador = orientador;
        this.bolsa = bolsa;
    }

    public int getBolsa() {
        return bolsa;
    }

    public void setBolsa(int bolsa) {
        if (bolsa <= 0)
            throw new IllegalArgumentException("O valor da bolsa mensal tem que positivo");

        this.bolsa = bolsa;
    }

    public Professor getOrientador() {
        return orientador;
    }

    public void setOrientador(Professor orientador) {
        if (orientador == null)
            throw new IllegalArgumentException("O professor orientador não pode ser nulo");

        this.orientador = orientador;
    }

    @Override
    public String toString() {
        return String.format("%s; bolsa: %d; orientador: %s",
                super.toString(),
                this.bolsa,
                this.orientador.getName()
        );
    }
}
