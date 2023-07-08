package aula12;

import utils.UserInput;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Ex03 {
    public static void main(String[] args) {
        try (Scanner input = new Scanner(new FileReader("aula12/movies.txt"))) {
            final Map<String, Integer> header = readHeader(input);
            final Set<Movie> movies = readMovies(input, header);

            // b)
            System.out.println(movies);

            // c)
            final Stream<Movie> scoreSorted = movies.stream().sorted(Comparator.comparing(Movie::getScore).reversed());
            System.out.println("\nSorted by score:");
            scoreSorted.forEach(System.out::println);

            final Stream<Movie> runningTimeSorted =
                    movies.stream().sorted(Comparator.comparing(Movie::getRunningTime).reversed());
            System.out.println("\nSorted by running time:");
            runningTimeSorted.forEach(System.out::println);

            // d)
            final Map<String, Set<Movie>> genres = new HashMap<>();

            for (Movie movie : movies) {
                final String genre = movie.getGenre();
                final Set<Movie> gMovies = genres.computeIfAbsent(genre, _genre -> new HashSet<>());
                gMovies.add(movie);
            }

            System.out.println("\nGenres:");
            for (Map.Entry<String, Set<Movie>> entry : genres.entrySet()) {
                System.out.println(entry.getKey() + ": " + entry.getValue().size());
            }

            // e)
            final String genre = UserInput.prompt("\nInsert a genre: ");
            final Set<Movie> gMovies = genres.get(genre);
            try (FileWriter output = new FileWriter("aula12/myselection.txt")) {
                for (Movie movie : gMovies) {
                    if (movie.getScore() > 60)
                        output.write(movie + "\n");
                }
            } catch (IOException e) {
                System.err.println("Error writing file");
                System.exit(1);
            }
        } catch (FileNotFoundException e) {
            System.err.println("Movies file not found");
            System.exit(1);
        }
    }

    public static Map<String, Integer> readHeader(Scanner input) {
        final Map<String, Integer> columnMap = new HashMap<>();

        final String line = input.nextLine();
        final String[] parts = line.split("\t");

        for (int i = 0; i < parts.length; i++) {
            final String colName = parts[i].toLowerCase();
            columnMap.put(colName, i);
        }

        return columnMap;
    }

    public static Set<Movie> readMovies(Scanner input, Map<String, Integer> header) {
        final Set<Movie> movies = new TreeSet<>(Comparator.comparing(Movie::getName));

        final int nameCol = header.get("name");
        final int scoreCol = header.get("score");
        final int ratingCol = header.get("rating");
        final int genreCol = header.get("genre");
        final int runningTimeCol = header.get("running time");

        while (input.hasNextLine()) {
            final String line = input.nextLine();
            final String[] parts = line.split("\t");

            final String name = parts[nameCol];
            final float score = Float.parseFloat(parts[scoreCol]);
            final String rating = parts[ratingCol];
            final String genre = parts[genreCol];
            final int runningTime = Integer.parseInt(parts[runningTimeCol]);

            movies.add(new Movie(name, score, rating, genre, runningTime));
        }

        return movies;
    }
}
