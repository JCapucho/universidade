package aula06;

import utils.DateYMD;

public class Professor extends Pessoa {
    private String categoria;
    private String departamento;

    public Professor(String iNome, int iBI, DateYMD iDataNasc, String categoria, String departamento) {
        super(iNome, iBI, iDataNasc);

        validateCategoria(categoria);

        if (departamento == null || departamento.length() == 0)
            throw new IllegalArgumentException("O departamento não pode estar vazio");

        this.categoria = categoria;
        this.departamento = departamento;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        validateCategoria(categoria);

        this.categoria = categoria;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    private static void validateCategoria(String categoria) throws IllegalArgumentException {
        if (categoria == null)
            throw new IllegalArgumentException("A categoria não pode ser nula");

        switch (categoria) {
            case "Auxiliar":
            case "Associado":
            case "Catedrático":
                return;
            default:
                throw new IllegalArgumentException("A categoria tem de ser uma de “Auxiliar”, “Associado”, “Catedrático”");
        }
    }

    @Override
    public String toString() {
        return String.format("%s; professor %s; departamento: %s",
                super.toString(),
                this.categoria,
                this.departamento
        );
    }
}
