package aula10;

import utils.Random;

import java.util.*;

public class Ex02 {
    private static final Map<String, List<Book>> mapaGeneroLivro = new TreeMap<>();

    private static List<Book> createBookCollection(Book... books) {
        final Vector<Book> col = new Vector<>();
        Collections.addAll(col, books);
        return col;
    }

    public static void main(String[] args) {
        // Adicionar
        mapaGeneroLivro.put("Comedy", createBookCollection(new Book("What If? 2", "Randall Munroe", 2022), new Book(
                "What If?", "Randall Munroe", 2014)));
        mapaGeneroLivro.put("Horror", createBookCollection(new Book("What horror", "Hmm", 2021)));
        mapaGeneroLivro.put("Drama", createBookCollection(new Book("What drama", "Hhh", 2019)));
        mapaGeneroLivro.put("Scientific", createBookCollection(new Book("What science", "lom", 2021)));
        mapaGeneroLivro.put("Mystery", createBookCollection(new Book("???", "ppp", 2007)));

        // Alterar
        mapaGeneroLivro.put("Scientific", createBookCollection(new Book("They made science 2!", "lom", 2021)));

        // Remover
        mapaGeneroLivro.remove("Drama");

        // toString
        System.out.println(mapaGeneroLivro);

        // Pares género-livro
        for (Map.Entry<String, List<Book>> entry : mapaGeneroLivro.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }

        // Géneros
        System.out.println(mapaGeneroLivro.keySet());

        // Livros
        List<Book> books = new ArrayList<>();
        mapaGeneroLivro.values().forEach(books::addAll);
        System.out.println(books);

        // Random
        System.out.println(getRandomBookByGender(mapaGeneroLivro, "Comedy"));
    }

    public static Book getRandomBookByGender(Map<String, List<Book>> mapa, String gender) {
        List<Book> books = mapa.get(gender);
        int index = Random.randomIntRange(0, books.size() - 1);
        return books.get(index);
    }
}
