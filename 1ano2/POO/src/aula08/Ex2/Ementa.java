package aula08.Ex2;

import java.time.LocalDateTime;
import java.util.Vector;

public class Ementa {
    private String nome;
    private String local;
    private Prato[] pratos = new Prato[DiaSemana.values().length];

    public Ementa(String nome, String local) {
        this.setNome(nome);
        this.setLocal(local);
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        if (nome == null || nome.length() == 0)
            throw new IllegalArgumentException("O nome não pode ser nulo");

        this.nome = nome;
    }

    public String getLocal() {
        return local;
    }

    public void setLocal(String local) {
        if (local == null || local.length() == 0)
            throw new IllegalArgumentException("O local não pode ser nulo");

        this.local = local;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();

        for (DiaSemana dia : DiaSemana.values()) {
            Prato prato = pratos[dia.ordinal()];

            if (prato == null)
                continue;

            builder.append(prato).append(", dia ").append(dia).append("\n");
        }

        return builder.toString();
    }

    public void addPrato(Prato prato, DiaSemana dia) {
        this.pratos[dia.ordinal()] = prato;
    }

    public void removePrato(DiaSemana dia) {
        this.pratos[dia.ordinal()] = null;
    }
}
