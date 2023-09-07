package aula11;

public class Voo {
    private Time hora;
    private String nome;
    private String companhia;
    private String origem;
    private Time atraso;

    public Voo(Time hora, String nome, String companhia, String origem, Time atraso) {
        if (hora == null)
            throw new IllegalArgumentException("A hora de partida não pode ser nula");

        if (nome == null || nome.isEmpty())
            throw new IllegalArgumentException("O nome do voo não pode ser nulo");

        if (companhia == null || companhia.isEmpty())
            throw new IllegalArgumentException("O nome da companhia não pode ser nulo");

        if (origem == null || origem.isEmpty())
            throw new IllegalArgumentException("A origem não pode ser nula");

        this.hora = hora;
        this.nome = nome;
        this.companhia = companhia;
        this.origem = origem;
        this.atraso = atraso;
    }

    public Time getHora() {
        return hora;
    }

    public String getNome() {
        return nome;
    }

    public String getCompanhia() {
        return companhia;
    }

    public String getOrigem() {
        return origem;
    }

    public Time getAtraso() {
        return atraso;
    }

    public void setAtraso(Time atraso) {
        this.atraso = atraso;
    }

    public Time tempoPrevisto() {
        return this.hora.add(this.atraso);
    }
}
