package utils;

import java.util.InputMismatchException;
import java.util.Scanner;

/**
 * Helper class for dealing with user input
 */
public class UserInput {
    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer.
     *
     * @param sc     the instance that will be used to get the user input
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @return the number inserted by the user
     */
    public static int promptInt(Scanner sc, String prompt) {
        System.out.print(prompt);
        return sc.nextInt();
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's greater or equal than the provided minimum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param sc     the instance that will be used to get the user input
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param min    the lower limit of the number the user must insert (inclusive)
     * @return the number inserted by the user
     */
    public static int promptIntMin(Scanner sc, String prompt, int min) {
        return promptIntMin(sc, prompt, min, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's greater or equal (if the exclusive argument is false)
     * or just greater (if exclusive is true) than the provided minimum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param sc        the instance that will be used to get the user input
     * @param prompt    the text to be printed to the terminal before waiting for the input
     * @param min       the lower limit of the number the user must insert
     * @param exclusive controls if the limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static int promptIntMin(Scanner sc, String prompt, int min, boolean exclusive) {
        return promptIntRange(sc, prompt, min, exclusive, Integer.MAX_VALUE, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's less or equal than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param sc     the instance that will be used to get the user input
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param max    the upper limit of the number the user must insert (inclusive)
     * @return the number inserted by the user
     */
    public static int promptIntMax(Scanner sc, String prompt, int max) {
        return promptIntMax(sc, prompt, max, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's less or equal (if the exclusive argument is false)
     * or just less (if exclusive is true) than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param sc        the instance that will be used to get the user input
     * @param prompt    the text to be printed to the terminal before waiting for the input
     * @param max       the upper limit of the number the user must insert
     * @param exclusive controls if the limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static int promptIntMax(Scanner sc, String prompt, int max, boolean exclusive) {
        return promptIntRange(sc, prompt, Integer.MIN_VALUE, false, max, exclusive);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's greater or equal than the provided minimum limit
     * and less or equal than the provided maximum limit, repeats the prompt until
     * a valid number is inserted.
     *
     * @param sc     the instance that will be used to get the user input
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param min    the lower limit of the number the user must insert
     * @param max    the upper limit of the number the user must insert
     * @return the number inserted by the user
     */
    public static int promptIntRange(Scanner sc, String prompt, int min, int max) {
        return promptIntRange(sc, prompt, min, false, max, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's greater or equal (if the minExclusive argument is false)
     * or just greater (if minExclusive is true) than the provided minimum limit,
     * and less or equal (if the maxExclusive argument is false)
     * or just less (if maxExclusive is true) than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param sc           the instance that will be used to get the user input
     * @param prompt       the text to be printed to the terminal before waiting for the input
     * @param min          the lower limit of the number the user must insert
     * @param minExclusive controls if the lower limit is exclusive (true) or inclusive (false)
     * @param max          the upper limit of the number the user must insert
     * @param maxExclusive controls if the upper limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static int promptIntRange(Scanner sc, String prompt, int min, boolean minExclusive, int max, boolean maxExclusive) {
        int value;
        while (true) {
            try {
                value = promptInt(sc, prompt);
            } catch (InputMismatchException e) {
                sc.nextLine();
                System.out.println("O valor têm que ser um inteiro");
                continue;
            }

            boolean minGood = minExclusive && min < value || !minExclusive && min <= value;
            boolean maxGood = maxExclusive && max > value || !maxExclusive && max >= value;

            if (minGood && maxGood)
                break;

            String minBound = minExclusive ? "]" : "[";
            String maxBound = maxExclusive ? "[" : "]";
            System.out.printf("O valor têm que estar entre %s%d, %d%s\n", minBound, min, max, maxBound);
        }
        return value;
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double.
     *
     * @param sc     the instance that will be used to get the user input
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @return the number inserted by the user
     */
    public static double promptDouble(Scanner sc, String prompt) {
        System.out.print(prompt);
        return sc.nextDouble();
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's greater or equal than the provided minimum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param sc     the instance that will be used to get the user input
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param min    the lower limit of the number the user must insert (inclusive)
     * @return the number inserted by the user
     */
    public static double promptDoubleMin(Scanner sc, String prompt, double min) {
        return promptDoubleMin(sc, prompt, min, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's greater or equal (if the exclusive argument is false)
     * or just greater (if exclusive is true) than the provided minimum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param sc        the instance that will be used to get the user input
     * @param prompt    the text to be printed to the terminal before waiting for the input
     * @param min       the lower limit of the number the user must insert
     * @param exclusive controls if the limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static double promptDoubleMin(Scanner sc, String prompt, double min, boolean exclusive) {
        return promptDoubleRange(sc, prompt, min, exclusive, Double.POSITIVE_INFINITY, true);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's less or equal than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param sc     the instance that will be used to get the user input
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param max    the upper limit of the number the user must insert (inclusive)
     * @return the number inserted by the user
     */
    public static double promptDoubleMax(Scanner sc, String prompt, double max) {
        return promptDoubleMax(sc, prompt, max, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's less or equal (if the exclusive argument is false)
     * or just less (if exclusive is true) than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param sc        the instance that will be used to get the user input
     * @param prompt    the text to be printed to the terminal before waiting for the input
     * @param max       the upper limit of the number the user must insert
     * @param exclusive controls if the limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static double promptDoubleMax(Scanner sc, String prompt, double max, boolean exclusive) {
        return promptDoubleRange(sc, prompt, Double.NEGATIVE_INFINITY, true, max, exclusive);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's greater or equal than the provided minimum limit
     * and less or equal than the provided maximum limit, repeats the prompt until
     * a valid number is inserted.
     *
     * @param sc     the instance that will be used to get the user input
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param min    the lower limit of the number the user must insert
     * @param max    the upper limit of the number the user must insert
     * @return the number inserted by the user
     */
    public static double promptDoubleRange(Scanner sc, String prompt, double min, double max) {
        return promptDoubleRange(sc, prompt, min, false, max, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's greater or equal (if the minExclusive argument is false)
     * or just greater (if minExclusive is true) than the provided minimum limit,
     * and less or equal (if the maxExclusive argument is false)
     * or just less (if maxExclusive is true) than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param sc           the instance that will be used to get the user input
     * @param prompt       the text to be printed to the terminal before waiting for the input
     * @param min          the lower limit of the number the user must insert
     * @param minExclusive controls if the lower limit is exclusive (true) or inclusive (false)
     * @param max          the upper limit of the number the user must insert
     * @param maxExclusive controls if the upper limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static double promptDoubleRange(Scanner sc, String prompt, double min, boolean minExclusive, double max, boolean maxExclusive) {
        double value;
        while (true) {
            try {
                value = promptDouble(sc, prompt);
            } catch (InputMismatchException e) {
                sc.nextLine();
                System.out.println("O valor têm que ser um real");
                continue;
            }

            boolean minGood = minExclusive && min < value || !minExclusive && min <= value;
            boolean maxGood = maxExclusive && max > value || !maxExclusive && max >= value;

            if (minGood && maxGood)
                break;

            String minBound = minExclusive ? "]" : "[";
            String maxBound = maxExclusive ? "[" : "]";
            System.out.printf("O valor têm que estar entre %s%f, %f%s\n", minBound, min, max, maxBound);
        }
        return value;
    }
}
