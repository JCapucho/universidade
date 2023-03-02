package utils;

/**
 * Helper class for generating random values
 */
public class Random {

    /**
     * Generates a random double between [min, max].
     *
     * @param min the minimum value of the generated value
     * @param max the maximum value of the generated value
     * @return a random value belonging to [min, max]
     */
    public static double randomDoubleRange(double min, double max) {
        return Math.random() * (max - min) + min;
    }

    /**
     * Generates a random integer between [min, max].
     *
     * @param min the minimum value of the generated value
     * @param max the maximum value of the generated value
     * @return a random value belonging to [min, max]
     */
    public static int randomIntRange(int min, int max) {
        return (int) randomDoubleRange(min, max);
    }
}
