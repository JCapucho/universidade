package aula09;

import java.util.*;

import aula06.Pessoa;
import utils.DateYMD;

import aula07.Date;

public class ALDemo {
    public static void main(String[] args) {
        ArrayList<Integer> c1 = new ArrayList<>();
        for (int i = 10; i <= 100; i += 10)
            c1.add(i);
        System.out.println("Size: " + c1.size());
        for (int i = 0; i < c1.size(); i++)
            System.out.println("Elemento: " + c1.get(i));

        ArrayList<String> c2 = new ArrayList<>();
        c2.add("Vento");
        c2.add("Calor");
        c2.add("Frio");
        c2.add("Chuva");
        System.out.println(c2);
        Collections.sort(c2);
        System.out.println(c2);
        c2.remove("Frio");
        c2.remove(0);
        System.out.println(c2);

        // 9.1 a)
        System.out.println(c2.indexOf("Frio"));
        System.out.println(c2.subList(1, 2));

        // 9.1 b)
        Set<Pessoa> c3 = new HashSet<>();
        c3.add(new Pessoa("Hopper", 117, new DateYMD(1, 1, 1)));
        c3.add(new Pessoa("João", 113, new DateYMD(1, 1, 1)));
        c3.add(new Pessoa("Marco", 115, new DateYMD(1, 1, 1)));
        c3.add(new Pessoa("José", 114, new DateYMD(1, 1, 1)));
        c3.add(new Pessoa("Pascal", 116, new DateYMD(1, 1, 1)));

        // A ordem de iteração é diferente da ordem de inserção
        for (Pessoa pessoa : c3) {
            System.out.println(pessoa);
        }

        // Um set não contêm elementos repetidos logo o add não deve adicionar
        // o elemento neste caso e retornar false.
        if (c3.add(new Pessoa("Hopper", 117, new DateYMD(1, 1, 1)))) throw new AssertionError();

        // 9.1 c)
        Set<Date> c4 = new TreeSet<>();

        c4.add(new aula07.DateYMD(2, 4, 2022));
        c4.add(new aula07.DateND(68));
        c4.add(new aula07.DateYMD(2, 1, 2022));
        c4.add(new aula07.DateND(50));
        c4.add(new aula07.DateYMD(2, 5, 2022));

        // A ordem de iteração é diferente da ordem de inserção, a ordem
        // de iteração está ordenada segundo o compareTo.
        for (Date date : c4) {
            System.out.println(date);
        }
    }
}
