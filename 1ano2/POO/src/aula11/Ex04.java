package aula11;

import java.io.*;
import java.util.*;

public class Ex04 {
    public static void main(String[] args) throws IOException {
        final Map<String, String> companhias = loadCompanhias();
        final List<Voo> voos = loadVoos(companhias);

        // a)
        printReport(voos, System.out);
        // b)
        final PrintStream InfopublicoFile = new PrintStream("aula11/Infopublico.txt");
        printReport(voos, InfopublicoFile);
        InfopublicoFile.close();

        // c)
        printAtrasos(voos, System.out);

        // d)
        final PrintStream cidadesFile = new PrintStream("aula11/cidades.txt");
        printCidades(voos, cidadesFile);
        cidadesFile.close();
    }

    private static Map<String, String> loadCompanhias() throws IOException {
        final Scanner input = new Scanner(new FileReader("aula11/companhias.txt"));
        final Map<String, String> lookup = new HashMap<>();

        // Skip first line
        input.nextLine();

        while (input.hasNextLine()) {
            String line = input.nextLine();

            String[] parts = line.split("\\t");

            String sigla = parts[0];
            String companhia = parts[1];

            lookup.put(sigla, companhia);
        }

        input.close();

        return lookup;
    }

    private static List<Voo> loadVoos(Map<String, String> sigla_lookup) throws IOException {
        final Scanner input = new Scanner(new FileReader("aula11/voos.txt"));
        final List<Voo> voos = new ArrayList<>();

        // Skip first line
        input.nextLine();

        while (input.hasNextLine()) {
            String line = input.nextLine();

            String[] parts = line.split("\\t");

            Time hora = Time.parseTime(parts[0]);
            String vooStr = parts[1];
            String origem = parts[2];
            Time atraso = parts.length > 3 ? Time.parseTime(parts[3]) : null;

            String companhia = sigla_lookup.get(vooStr.substring(0, 2));

            voos.add(new Voo(hora, vooStr, companhia, origem, atraso));
        }

        input.close();

        return voos;
    }

    private static final void printReport(List<Voo> voos, PrintStream out) {
        final String vooHeader = "Voo";
        final String companhiaHeader = "Companhia";
        final String origemHeader = "Origen";

        int vooMaxLength = vooHeader.length();
        int companhiaMaxLength = companhiaHeader.length();
        int origemMaxLength = origemHeader.length();

        for (Voo voo : voos) {
            vooMaxLength = Integer.max(vooMaxLength, voo.getNome().length());
            companhiaMaxLength = Integer.max(companhiaMaxLength, voo.getCompanhia().length());
            origemMaxLength = Integer.max(origemMaxLength, voo.getOrigem().length());
        }

        String header = String.format(
                "Hora \t%s%s\t%s%s\t%s%s\tAtraso\tObs",
                vooHeader,
                " ".repeat(vooMaxLength - vooHeader.length()),
                companhiaHeader,
                " ".repeat(companhiaMaxLength - companhiaHeader.length()),
                origemHeader,
                " ".repeat(origemMaxLength - origemHeader.length()));

        out.println(header);

        for (Voo voo : voos) {
            String nome = voo.getNome();
            String companhia = voo.getCompanhia();
            String origem = voo.getOrigem();
            Time atraso = voo.getAtraso();

            String line = String.format(
                    "%s\t%s%s\t%s%s\t%s%s\t%s \t%s",
                    voo.getHora(),
                    nome,
                    " ".repeat(vooMaxLength - nome.length()),
                    companhia,
                    " ".repeat(companhiaMaxLength - companhia.length()),
                    origem,
                    " ".repeat(origemMaxLength - origem.length()),
                    atraso != null ? atraso : "",
                    atraso != null ? String.format("Previsto: %s", voo.tempoPrevisto()) : "");

            out.println(line);
        }
    }

    private static void printCidades(List<Voo> voos, PrintStream out) {
        final String origemHeader = "Origem";
        final Map<String, Integer> cidades = new HashMap<>();

        int maxOrigemLength = origemHeader.length();

        for (Voo voo : voos) {
            final String origem = voo.getOrigem();
            int numVoos = cidades.getOrDefault(origem, 0);
            cidades.put(origem, numVoos + 1);
            maxOrigemLength = Integer.max(maxOrigemLength, origem.length());
        }

        String header = String.format(
                "%s%s\tVoos",
                origemHeader,
                " ".repeat(maxOrigemLength - origemHeader.length()));

        out.println(header);

        final List<Map.Entry<String, Integer>> entries = new ArrayList<>(cidades.entrySet());
        entries.sort(Map.Entry.<String, Integer>comparingByValue().reversed());

        for (Map.Entry<String, Integer> entry : entries) {
            String line = String.format(
                    "%s%s\t%s",
                    entry.getKey(),
                    " ".repeat(maxOrigemLength - entry.getKey().length()),
                    entry.getValue());

            out.println(line);
        }
    }

    private static void printAtrasos(List<Voo> voos, PrintStream out) {
        class AtrasoInfo implements Comparable<AtrasoInfo> {
            public int totalMinutos = 0;
            public int voosAtrasados = 0;

            public Time atrasoMedio() {
                final int mediaMinutos = minutosMedio();
                final int hours = mediaMinutos / 60;
                final int minutes = mediaMinutos % 60;
                return new Time(hours, minutes);
            }

            private int minutosMedio() {
                return totalMinutos / voosAtrasados;
            }

            @Override
            public int compareTo(AtrasoInfo o) {
                return Integer.compare(this.minutosMedio(), o.minutosMedio());
            }
        }

        final String companhiaHeader = "Companhia";
        final Map<String, AtrasoInfo> atrasos = new HashMap<>();

        int maxCompanhiaLength = companhiaHeader.length();

        for (Voo voo : voos) {
            final String companhia = voo.getCompanhia();
            final Time atraso = voo.getAtraso();

            if (atraso == null)
                continue;

            AtrasoInfo info = atrasos.computeIfAbsent(companhia, _comp -> new AtrasoInfo());

            info.totalMinutos += atraso.getHours() * 60 + atraso.getMinutes();
            info.voosAtrasados += 1;

            maxCompanhiaLength = Integer.max(maxCompanhiaLength, companhia.length());
        }

        String header = String.format(
                "%s%s\tAtraso Médio",
                companhiaHeader,
                " ".repeat(maxCompanhiaLength - companhiaHeader.length()));

        out.println(header);

        final List<Map.Entry<String, AtrasoInfo>> entries = new ArrayList<>(atrasos.entrySet());
        entries.sort(Map.Entry.<String, AtrasoInfo>comparingByValue().reversed());

        for (Map.Entry<String, AtrasoInfo> entry : entries) {
            String line = String.format(
                    "%s%s\t%s",
                    entry.getKey(),
                    " ".repeat(maxCompanhiaLength - entry.getKey().length()),
                    entry.getValue().atrasoMedio());

            out.println(line);
        }
    }
}
