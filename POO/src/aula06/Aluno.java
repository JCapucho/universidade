package aula06;

import utils.DateYMD;

public class Aluno extends Pessoa {
    private int nmec;
    private DateYMD dataInsc;
    private static int nmecCounter = 100;

    public Aluno(String iNome, int iBI, DateYMD iDataNasc, DateYMD iDataInsc) {
        super(iNome, iBI, iDataNasc);

        if (iDataInsc == null)
            throw new IllegalArgumentException("A data de inscrição não pode ser nula");

        this.nmec = nmecCounter++;
        this.dataInsc = iDataInsc;
    }

    public Aluno(String iNome, int iBI, DateYMD iDataNasc) {
        this(iNome, iBI, iDataNasc, DateYMD.now());
    }

    public int getNMec() {
        return this.nmec;
    }


    public DateYMD getDataInsc() {
        return dataInsc;
    }

    @Override
    public String toString() {
        return String.format("%s; aluno desde %d/%d/%d; nmec: %d",
                super.toString(),
                this.dataInsc.getDay(),
                this.dataInsc.getMonth(),
                this.dataInsc.getYear(),
                this.nmec
        );
    }
}
