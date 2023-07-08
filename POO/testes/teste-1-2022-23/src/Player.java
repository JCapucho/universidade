package teste;

import java.util.Objects;

public abstract class Player {
    private String nome;
    private String clube;

    private final int id;
    private static int COUNTER = 0;

    public Player(String nome, String clube) {
        setNome(nome);
        setClube(clube);
        this.id = COUNTER++;
    }

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getClube() {
        return clube;
    }

    public void setNome(String nome) {
        if (nome == null || nome.length() == 0)
            throw new IllegalArgumentException("O nome não pode ser nulo ou vazio");

        this.nome = nome;
    }

    public void setClube(String clube) {
        if (clube == null || clube.length() == 0)
            throw new IllegalArgumentException("O clube não pode ser nulo ou vazio");

        this.clube = clube;
    }

    public abstract int matchWinner(Player other);

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Player player = (Player) o;

        return id == player.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "ID: " + id + "; Name: " + nome + "; Club: " + clube;
    }
}
