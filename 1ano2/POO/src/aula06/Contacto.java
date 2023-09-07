package aula06;

public class Contacto {
    private int id;
    private Pessoa pessoa;
    private String tele;
    private String email;

    private static int counter = 1;

    public Contacto(Pessoa pessoa, String tele, String email) {
        if (pessoa == null)
            throw new IllegalArgumentException("A pessoa não pode ser nula");

        if (tele == null && email == null)
            throw new IllegalArgumentException("O email e número do telemóvel não podem ser os dois nulos");

        if (tele != null && !validTele(tele))
            throw new IllegalArgumentException("O número de telemóvel deve conter 9 digitos e começar por 9");

        if (email != null && !validEmail(email))
            throw new IllegalArgumentException("O email tem que conter um @ e o domínio");

        this.id = counter++;
        this.pessoa = pessoa;
        this.tele = tele;
        this.email = email;
    }

    private static boolean validTele(String tele) {
        return tele.matches("^9[0-9]{8}$");
    }

    private static boolean validEmail(String email) {
        return email.matches("^.+@[^@]+\\.[^@]+$");
    }

    public int getId() {
        return id;
    }

    public Pessoa getPessoa() {
        return pessoa;
    }

    public String getTele() {
        return tele;
    }

    public String getEmail() {
        return email;
    }

    public void setTele(String tele) {
        if (tele == null && this.email == null)
            throw new IllegalArgumentException("O email e número do telemóvel não podem ser os dois nulos");

        if (!validTele(tele))
            throw new IllegalArgumentException("O número de telemóvel deve conter 9 digitos e começar por 9");

        this.tele = tele;
    }

    public void setEmail(String email) {
        if (this.tele == null && email == null)
            throw new IllegalArgumentException("O email e número do telemóvel não podem ser os dois nulos");

        if (!validEmail(email))
            throw new IllegalArgumentException("O número de telemóvel deve conter 9 digitos e começar por 9");

        this.email = email;
    }


    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        Contacto contacto = (Contacto) obj;

        return this.id == contacto.id;
    }

    @Override
    public String toString() {
        String accum = "ID: " + this.getId() + "; Nome: " + this.pessoa.getName();

        if (this.tele != null)
            accum += "; telemóvel: " + this.tele;

        if (this.email != null)
            accum += "; email: " + this.email;

        return accum;
    }
}
