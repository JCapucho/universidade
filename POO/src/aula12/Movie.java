package aula12;

import java.util.Objects;

public class Movie {
    private String name;
    private float score;
    private String rating;
    private String genre;
    private int runningTime;

    public Movie(String name, float score, String rating, String genre, int runningTime) {
        if (name == null || name.isEmpty())
            throw new IllegalArgumentException("The name cannot be null");

        if (score < 0 || score > 100)
            throw new IllegalArgumentException("The score must be between 0 and 100");

        if (genre == null || genre.isEmpty())
            throw new IllegalArgumentException("The genre cannot be null");

        if (rating == null || rating.isEmpty())
            throw new IllegalArgumentException("The rating cannot be null");

        if (runningTime <= 0)
            throw new IllegalArgumentException("The running time must be positive");

        this.name = name;
        this.score = score;
        this.rating = rating;
        this.genre = genre;
        this.runningTime = runningTime;
    }

    public String getName() {
        return name;
    }

    public float getScore() {
        return score;
    }

    public String getRating() {
        return rating;
    }

    public String getGenre() {
        return genre;
    }

    public int getRunningTime() {
        return runningTime;
    }

    

    @Override
    public String toString() {
        return String.format("%s\t%.1f\t%s\t%s\t%d",
                this.name,
                this.score,
                this.rating,
                this.genre,
                this.runningTime
        );
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Movie movie = (Movie) o;
        return Float.compare(movie.score, score) == 0
                && runningTime == movie.runningTime
                && Objects.equals(name, movie.name)
                && Objects.equals(rating, movie.rating)
                && Objects.equals(genre, movie.genre);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, score, rating, genre, runningTime);
    }
}
