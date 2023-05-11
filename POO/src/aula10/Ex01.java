package aula10;

import java.util.HashMap;
import java.util.Map;

public class Ex01 {
    private static final HashMap<String, Book> mapaGeneroLivro = new HashMap<>();

    public static void main(String[] args) {
        // Adicionar
        mapaGeneroLivro.put("Comedy", new Book("What If? 2", "Randall Munroe", 2022));
        mapaGeneroLivro.put("Horror", new Book("What horror", "Hmm", 2021));
        mapaGeneroLivro.put("Drama", new Book("What drama", "Hhh", 2019));
        mapaGeneroLivro.put("Scientific", new Book("What science", "lom", 2021));
        mapaGeneroLivro.put("Mystery", new Book("???", "ppp", 2007));

        // Alterar
        mapaGeneroLivro.put("Scientific", new Book("They made science 2!", "lom", 2021));

        // Remover
        mapaGeneroLivro.remove("Comedy");

        // toString
        System.out.println(mapaGeneroLivro);

        // Pares género-livro
        for (Map.Entry<String, Book> entry : mapaGeneroLivro.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }

        // Géneros
        System.out.println(mapaGeneroLivro.keySet());

        // Livros
        System.out.println(mapaGeneroLivro.values());
    }
}
