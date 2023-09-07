package aula06;

import utils.DateYMD;

import java.util.Objects;

public class Pessoa {
    private String nome;
    private int cc;
    private DateYMD dataNasc;

    public Pessoa(String nome, int cc, DateYMD dataNasc) {
        if (cc < 0)
            throw new IllegalArgumentException("O cc têm de ser positivo");

        if (nome == null || nome.length() == 0)
            throw new IllegalArgumentException("O nome não pode estar vazio");

        if (dataNasc == null)
            throw new IllegalArgumentException("A data de nascimento não pode ser nula");

        this.nome = nome;
        this.cc = cc;
        this.dataNasc = dataNasc;
    }

    public String getName() {
        return nome;
    }

    public void setName(String nome) {
        if (nome == null || nome.length() == 0)
            throw new IllegalArgumentException("O nome não pode estar vazio");

        this.nome = nome;
    }

    public int getCc() {
        return cc;
    }

    public DateYMD getDataNasc() {
        return dataNasc;
    }

    @Override
    public String toString() {
        return String.format("%s; CC: %d; Data de Nascimento: %d/%d/%d",
                this.nome,
                this.cc,
                this.dataNasc.getDay(),
                this.dataNasc.getMonth(),
                this.dataNasc.getYear()
        );
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Pessoa pessoa = (Pessoa) o;
        return cc == pessoa.cc;
    }

    @Override
    public int hashCode() {
        return Objects.hash(cc);
    }
}
