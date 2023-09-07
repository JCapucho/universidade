package POO2122Teste;

import java.util.Objects;

public class Client {
    private String nome;
    private String localidade;

    public Client(String nome, String localidade) {
        this.nome = nome;
        this.localidade = localidade;
    }

    public String getNome() {
        return nome;
    }

    public String getLocalidade() {
        return localidade;
    }

    @Override
    public String toString() {
        return String.format("%s [%s]", this.nome, this.localidade);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Client client = (Client) o;
        return Objects.equals(nome, client.nome) && Objects.equals(localidade, client.localidade);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nome, localidade);
    }
}
