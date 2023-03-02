package utils;

import java.util.function.Function;

/**
 * Represents a class that can be used to check if a user input of type T is valid or not.
 */
@FunctionalInterface
public interface InputValidator<T> {
    /**
     * Checks if the user input is valid otherwise an UserInputValidationException is thrown
     *
     * @param t the user input to be validated
     * @throws UserInputValidationException when the user input isn't valid
     */
    void apply(T t) throws UserInputValidationException;

    /**
     * Constructs a validator that uses a function to check if the input is valid or not.
     *
     * @param <T>       the type of the user input
     * @param predicate the function that will be used to determine if the input is valid or not
     * @param message   the error message used if the input isn't valid.
     * @return a validator that uses the predicate to determine if an input is valid or not
     */
    static <T> InputValidator<T> functional(Function<T, Boolean> predicate, String message) {
        return new FunctionalValidator<>(predicate, message);
    }

    /**
     * Constructs a validator that uses all passed validators when validating the user input.
     *
     * @param <T>        the type of the user input
     * @param validators the validators to be used when validating
     * @return a validator that uses all provided validators to check if an input is valid or not
     */
    static <T> InputValidator<T> composite(InputValidator<T>... validators) {
        return new CompositeValidator<>(validators);
    }

    /**
     * Constructs a validator that checks if the user input is greater or equal than the
     * provided limit.
     *
     * @param <T> the type of the user input
     * @param min the minimum limit to be used
     * @return a validator that checks if the input is greater or equal to min
     */
    static <T extends Number & Comparable> InputValidator<T> minValidator(T min) {
        return minValidator(min, false);
    }

    /**
     * Constructs a validator that checks if the user input is greater (if exclusive) or
     * greater or equal (if inclusive) than the provided limit.
     *
     * @param <T>          the type of the user input
     * @param min          the minimum limit to be used
     * @param minExclusive whether the limit is exclusive (true) or not (false)
     * @return a validator that checks if the input is greater (or equal if not exclusive) to min
     */
    static <T extends Number & Comparable> InputValidator<T> minValidator(T min, boolean minExclusive) {
        LimitBound<T> lower = LimitBound.fromBoolean(min, minExclusive);
        LimitBound<T> upper = LimitBound.none();
        return new LimitsValidator<>(lower, upper);
    }

    /**
     * Constructs a validator that checks if the user input is less or equal than the
     * provided limit.
     *
     * @param <T> the type of the user input
     * @param max the maximum limit to be used
     * @return a validator that checks if the input is less or equal to max
     */
    static <T extends Number & Comparable> InputValidator<T> maxValidator(T max) {
        return maxValidator(max, false);
    }

    /**
     * Constructs a validator that checks if the user input is less (if exclusive) or
     * less or equal (if inclusive) than the provided limit.
     *
     * @param <T>          the type of the user input
     * @param max          the maximum limit to be used
     * @param maxExclusive whether the limit is exclusive (true) or not (false)
     * @return a validator that checks if the input is less (or equal if not exclusive) to max
     */
    static <T extends Number & Comparable> InputValidator<T> maxValidator(T max, boolean maxExclusive) {
        LimitBound<T> lower = LimitBound.none();
        LimitBound<T> upper = LimitBound.fromBoolean(max, maxExclusive);
        return new LimitsValidator<>(lower, upper);
    }

    /**
     * Constructs a validator that checks if the user input belongs to the range
     * (inclusive) defined by the provided limits.
     *
     * @param <T> the type of the user input
     * @param min the minimum limit to be used
     * @param max the maximum limit to be used
     * @return a validator that checks if the input belongs to [min, max]
     */
    static <T extends Number & Comparable> InputValidator<T> rangeValidator(T min, T max) {
        return rangeValidator(min, max, false, false);
    }

    /**
     * Constructs a validator that checks if the user input belongs to the range
     * (can be configured as exclusive or inclusive) defined by the provided limits.
     *
     * @param <T>          the type of the user input
     * @param min          the minimum limit to be used
     * @param max          the maximum limit to be used
     * @param minExclusive whether the lower limit is exclusive (true) or not (false)
     * @param maxExclusive whether the upper limit is exclusive (true) or not (false)
     * @return a validator that checks if the input belongs to the range min
     * (exclusive if minExclusive) and max (exclusive if maxExclusive)
     */
    static <T extends Number & Comparable> InputValidator<T> rangeValidator(T min, T max, boolean minExclusive, boolean maxExclusive) {
        LimitBound<T> lower = LimitBound.fromBoolean(min, minExclusive);
        LimitBound<T> upper = LimitBound.fromBoolean(max, maxExclusive);
        return new LimitsValidator<>(lower, upper);
    }
}