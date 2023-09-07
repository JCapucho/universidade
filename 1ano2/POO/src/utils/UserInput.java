package utils;

import java.util.Scanner;
import java.util.InputMismatchException;

/**
 * Helper class for dealing with user input
 */
public final class UserInput {
    private final static Scanner scanner = new Scanner(System.in);

    /**
     * Dummy constructor to prevent UserInput from being instantiated
     */
    private UserInput() {
        throw new UnsupportedOperationException();
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert anything.
     *
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @return the string inserted by the user
     */
    public static String prompt(String prompt) {
        System.out.print(prompt);
        return scanner.nextLine();
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a string that passes the validator tests.
     *
     * @param prompt    the text to be printed to the terminal before waiting for the input
     * @param validator the validator to use for validating the input
     * @return the string inserted by the user
     */
    public static String promptValidator(String prompt, InputValidator<String> validator) {
        while (true) {
            String value = prompt(prompt);

            try {
                validator.apply(value);
            } catch (UserInputValidationException e) {
                System.out.println(e.getMessage());
                continue;
            }

            return value;
        }
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer.
     *
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @return the number inserted by the user
     */
    public static int promptInt(String prompt) {
        while (true) {
            System.out.print(prompt);
            try {
                int input = scanner.nextInt();
                // Consume the newline after the number
                scanner.nextLine();
                return input;
            } catch (InputMismatchException e) {
                scanner.nextLine();
                System.out.println("O valor têm que ser um inteiro");
            }
        }
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's greater or equal than the provided minimum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param min    the lower limit of the number the user must insert (inclusive)
     * @return the number inserted by the user
     */
    public static int promptIntMin(String prompt, int min) {
        return promptIntMin(prompt, min, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's greater or equal (if the exclusive argument is false)
     * or just greater (if exclusive is true) than the provided minimum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param prompt    the text to be printed to the terminal before waiting for the input
     * @param min       the lower limit of the number the user must insert
     * @param exclusive controls if the limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static int promptIntMin(String prompt, int min, boolean exclusive) {
        InputValidator<Integer> validator = InputValidator.minValidator(min, exclusive);
        return promptIntValidator(prompt, validator);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's less or equal than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param max    the upper limit of the number the user must insert (inclusive)
     * @return the number inserted by the user
     */
    public static int promptIntMax(String prompt, int max) {
        return promptIntMax(prompt, max, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's less or equal (if the exclusive argument is false)
     * or just less (if exclusive is true) than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param prompt    the text to be printed to the terminal before waiting for the input
     * @param max       the upper limit of the number the user must insert
     * @param exclusive controls if the limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static int promptIntMax(String prompt, int max, boolean exclusive) {
        InputValidator<Integer> validator = InputValidator.maxValidator(max, exclusive);
        return promptIntValidator(prompt, validator);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's greater or equal than the provided minimum limit
     * and less or equal than the provided maximum limit, repeats the prompt until
     * a valid number is inserted.
     *
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param min    the lower limit of the number the user must insert
     * @param max    the upper limit of the number the user must insert
     * @return the number inserted by the user
     */
    public static int promptIntRange(String prompt, int min, int max) {
        return promptIntRange(prompt, min, false, max, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that's greater or equal (if the minExclusive argument is false)
     * or just greater (if minExclusive is true) than the provided minimum limit,
     * and less or equal (if the maxExclusive argument is false)
     * or just less (if maxExclusive is true) than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param prompt       the text to be printed to the terminal before waiting for the input
     * @param min          the lower limit of the number the user must insert
     * @param minExclusive controls if the lower limit is exclusive (true) or inclusive (false)
     * @param max          the upper limit of the number the user must insert
     * @param maxExclusive controls if the upper limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static int promptIntRange(String prompt, int min, boolean minExclusive, int max, boolean maxExclusive) {
        InputValidator<Integer> validator = InputValidator.rangeValidator(min, max, minExclusive, maxExclusive);
        return promptIntValidator(prompt, validator);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an integer that passes the validator tests.
     *
     * @param prompt    the text to be printed to the terminal before waiting for the input
     * @param validator the validator to use for validating the input
     * @return the number inserted by the user
     */
    public static int promptIntValidator(String prompt, InputValidator<Integer> validator) {
        while (true) {
            int value = promptInt(prompt);

            try {
                validator.apply(value);
            } catch (UserInputValidationException e) {
                System.out.println(e.getMessage());
                continue;
            }

            return value;
        }
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double.
     *
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @return the number inserted by the user
     */
    public static double promptDouble(String prompt) {
        while (true) {
            System.out.print(prompt);
            try {
                double input = scanner.nextDouble();
                // Consume the newline after the number
                scanner.nextLine();
                return input;
            } catch (InputMismatchException e) {
                scanner.nextLine();
                System.out.println("O valor têm que ser um real");
            }
        }
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's greater or equal than the provided minimum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param min    the lower limit of the number the user must insert (inclusive)
     * @return the number inserted by the user
     */
    public static double promptDoubleMin(String prompt, double min) {
        return promptDoubleMin(prompt, min, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's greater or equal (if the exclusive argument is false)
     * or just greater (if exclusive is true) than the provided minimum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param prompt    the text to be printed to the terminal before waiting for the input
     * @param min       the lower limit of the number the user must insert
     * @param exclusive controls if the limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static double promptDoubleMin(String prompt, double min, boolean exclusive) {
        InputValidator<Double> validator = InputValidator.minValidator(min, exclusive);
        return promptDoubleValidator(prompt, validator);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's less or equal than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param max    the upper limit of the number the user must insert (inclusive)
     * @return the number inserted by the user
     */
    public static double promptDoubleMax(String prompt, double max) {
        return promptDoubleMax(prompt, max, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's less or equal (if the exclusive argument is false)
     * or just less (if exclusive is true) than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param prompt    the text to be printed to the terminal before waiting for the input
     * @param max       the upper limit of the number the user must insert
     * @param exclusive controls if the limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static double promptDoubleMax(String prompt, double max, boolean exclusive) {
        InputValidator<Double> validator = InputValidator.maxValidator(max, exclusive);
        return promptDoubleValidator(prompt, validator);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's greater or equal than the provided minimum limit
     * and less or equal than the provided maximum limit, repeats the prompt until
     * a valid number is inserted.
     *
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @param min    the lower limit of the number the user must insert
     * @param max    the upper limit of the number the user must insert
     * @return the number inserted by the user
     */
    public static double promptDoubleRange(String prompt, double min, double max) {
        return promptDoubleRange(prompt, min, false, max, false);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a double that's greater or equal (if the minExclusive argument is false)
     * or just greater (if minExclusive is true) than the provided minimum limit,
     * and less or equal (if the maxExclusive argument is false)
     * or just less (if maxExclusive is true) than the provided maximum limit,
     * repeats the prompt until a valid number is inserted.
     *
     * @param prompt       the text to be printed to the terminal before waiting for the input
     * @param min          the lower limit of the number the user must insert
     * @param minExclusive controls if the lower limit is exclusive (true) or inclusive (false)
     * @param max          the upper limit of the number the user must insert
     * @param maxExclusive controls if the upper limit is exclusive (true) or inclusive (false)
     * @return the number inserted by the user
     */
    public static double promptDoubleRange(String prompt, double min, boolean minExclusive, double max,
                                           boolean maxExclusive) {
        InputValidator<Double> validator = InputValidator.rangeValidator(min, max, minExclusive, maxExclusive);
        return promptDoubleValidator(prompt, validator);
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert an double that passes the validator tests.
     *
     * @param prompt    the text to be printed to the terminal before waiting for the input
     * @param validator the validator to use for validating the input
     * @return the number inserted by the user
     */
    public static double promptDoubleValidator(String prompt, InputValidator<Double> validator) {
        while (true) {
            double value = promptDouble(prompt);

            try {
                validator.apply(value);
            } catch (UserInputValidationException e) {
                System.out.println(e.getMessage());
                continue;
            }

            return value;
        }
    }

    /**
     * Prints to the terminal a menu with options and waits for the user to select
     * one of them.
     *
     * @param options the options to be listed in the menu
     * @return the number inserted by the user
     */
    public static int menuSelection(String... options) {
        for (String option : options)
            System.out.println(option);

        return UserInput.promptIntRange("Insira a sua seleção: ", 0, options.length - 1);
    }

    public static <T extends Enum<T>> T enumSelection(Class<T> enumType) {
        T[] values = enumType.getEnumConstants();

        for (int i = 0; i < values.length; i++)
            System.out.printf("%d: %s\n", i, values[i].toString());

        int sel = UserInput.promptIntRange("Insira a sua seleção: ", 0, values.length - 1);

        return values[sel];
    }

    /**
     * Prints to the terminal the prompt argument and waits for the user to
     * insert a valid date.
     *
     * @param prompt the text to be printed to the terminal before waiting for the input
     * @return the date inserted by the user
     */
    public static DateYMD promptDate(String prompt) {
        while (true) {
            System.out.println(prompt);
            int day = UserInput.promptInt("dia: ");
            int month = UserInput.promptInt("mês: ");
            int year = UserInput.promptInt("ano: ");

            try {
                return new DateYMD(day, month, year);
            } catch (IllegalArgumentException e) {
                System.out.println(e.getMessage());
            }
        }
    }
}
