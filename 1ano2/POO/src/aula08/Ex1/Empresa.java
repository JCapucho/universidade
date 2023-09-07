package aula08.Ex1;

import java.util.*;

public class Empresa {
    private String nome;
    private String codigoPostal;
    private String email;

    private Vector<Viatura> viaturas;

    public Empresa(String nome, String codigoPostal, String email, Viatura... viaturas) {
        if (viaturas == null)
            throw new IllegalArgumentException();

        this.setNome(nome);
        this.setCodigoPostal(codigoPostal);
        this.setEmail(email);
        this.viaturas = new Vector<>(Arrays.asList(viaturas));
    }

    public String getNome() {
        return nome;
    }

    public String getCodigoPostal() {
        return codigoPostal;
    }

    public String getEmail() {
        return email;
    }

    public List<Viatura> getViaturas() {
        return Collections.unmodifiableList(this.viaturas);
    }

    public void setNome(String nome) {
        if (nome == null || nome.length() == 0)
            throw new IllegalArgumentException();

        this.nome = nome;
    }

    public void setCodigoPostal(String codigoPostal) {
        if (codigoPostal == null || !codigoPostal.matches("^\\d{4}-\\d{3}$"))
            throw new IllegalArgumentException();

        this.codigoPostal = codigoPostal;
    }

    public void setEmail(String email) {
        if (email == null || !email.matches("^\\S+@\\S+$"))
            throw new IllegalArgumentException();

        this.email = email;
    }

    public void addViatura(Viatura viatura) {
        this.viaturas.add(viatura);
    }

    public void removeViatura(Viatura viatura) {
        this.viaturas.remove(viatura);
    }

    @Override
    public String toString() {
        StringBuilder accum = new StringBuilder(
                String.format("Empresa; Nome: %s; Código Postal: %s; Email: %s; Frota:\n",
                        this.nome, this.codigoPostal, this.email)
        );

        for (Viatura viatura : this.viaturas) {
            accum.append("\t").append(viatura.toString()).append("\n");
        }

        return accum.toString();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Empresa empresa = (Empresa) o;
        return Objects.equals(nome, empresa.nome) && Objects.equals(codigoPostal, empresa.codigoPostal) && Objects.equals(email, empresa.email) && Objects.equals(viaturas, empresa.viaturas);
    }

    @Override
    public int hashCode() {
        return Objects.hash(nome, codigoPostal, email, viaturas);
    }
}
