package utils;

/**
 * The type of a bound on a limit.
 */
enum BoundType {
    /**
     * There's no limit.
     */
    None,
    /**
     * The limit is inclusive.
     */
    Inclusive,
    /**
     * The limit is exclusive.
     */
    Exclusive
}

/**
 * Defines how a limit is handled when validating
 */
final class LimitBound<T> {
    // The value of the limit
    final T value;
    // The type of bound.
    final BoundType type;

    /**
     * Constructs a new limit bound with the value of the limit and the type of the bound.
     * <p>
     * This constructor is internal to the class's operation and shouldn't be used, instead
     * the helper static methods should be used.
     *
     * @param value the value of the limit
     * @param type  the type of bound
     */
    private LimitBound(T value, BoundType type) {
        this.type = type;
        this.value = value;
    }

    /**
     * Constructs a new bound that isn't limited.
     *
     * @return a bound that isn't limited
     */
    public static <K> LimitBound<K> none() {
        return new LimitBound<>(null, BoundType.None);
    }

    /**
     * Constructs a new bound with an inclusive limit.
     *
     * @param value the value of the limit
     * @return an inclusive bound
     */
    public static <K> LimitBound<K> inclusive(K value) {
        return new LimitBound<>(value, BoundType.Inclusive);
    }

    /**
     * Constructs a new bound with an exclusive limit.
     *
     * @param value the value of the limit
     * @return an exclusive bound
     */
    public static <K> LimitBound<K> exclusive(K value) {
        return new LimitBound<>(value, BoundType.Exclusive);
    }

    /**
     * Constructs a new bound with a limit and the inclusivity is configured by a boolean.
     *
     * @param value     the value of the limit
     * @param exclusive whether the bound is exclusive or not
     * @return a limited bound that is exclusive if exclusive is true otherwise is inclusive
     */
    public static <K> LimitBound<K> fromBoolean(K value, boolean exclusive) {
        return new LimitBound<>(value, exclusive ? BoundType.Exclusive : BoundType.Inclusive);
    }
}

/**
 * Validator that checks if the user input is within the configured limits
 */
final class LimitsValidator<T extends Number & Comparable> implements InputValidator<T> {
    /**
     * Helper interface to represent a binary function that provides a comparison
     * against a bound.
     */
    @FunctionalInterface
    interface Comparator<T> {
        /**
         * Returns the result of the comparison between the value and the bound.
         *
         * @param value the value to be compared
         * @param bound the value of the bound
         * @return whether the value passes the comparison
         */
        boolean apply(T value, T bound);
    }

    // The lower limit bound to be applied
    private final LimitBound<T> lower;
    // The upper limit bound to be applied
    private final LimitBound<T> upper;

    /**
     * Constructs a new limits validator from a lower and upper limit.
     *
     * @param lower the lower limit
     * @param upper the upper limit
     */
    public LimitsValidator(LimitBound<T> lower, LimitBound<T> upper) {
        this.lower = lower;
        this.upper = upper;
    }

    /**
     * Helper method to check if the value is within the given limit.
     *
     * @param bound      the limit bound to check the value against
     * @param value      the value to be checked
     * @param comparator the function to be used to determine if the value is within the limit's value (exclusive)
     * @return whether or not the value respects the bound
     */
    private boolean checkBound(LimitBound<T> bound, T value, Comparator<T> comparator) {
        switch (bound.type) {
            case None -> {
                return true;
            }
            case Inclusive -> {
                return comparator.apply(value, bound.value) || value.equals(bound.value);
            }
            case Exclusive -> {
                return comparator.apply(value, bound.value);
            }
        }

        return true;
    }

    /**
     * Helper to generate an exception when only one bound is in place and the value doesn't respect it.
     *
     * @param bound     the limit bound the value was checked against
     * @param predicate the comparison that the value didn't pass
     * @return a new UserInputValidationException with the correct message for the bound
     */
    private UserInputValidationException oneSideLimitException(LimitBound<T> bound, String predicate) {
        String exclusivity = lower.type == BoundType.Inclusive ? "inclusivo" : "exclusivo";
        String error = String.format("O valor têm que ser %s que %s (%s)", predicate, bound.value.toString(), exclusivity);

        return new UserInputValidationException(error);
    }

    @Override
    public void apply(T value) throws UserInputValidationException {
        boolean lowerGood = checkBound(lower, value, (v, limit) -> v.compareTo(limit) > 0);
        boolean upperGood = checkBound(upper, value, (v, limit) -> v.compareTo(limit) < 0);

        if (lowerGood && upperGood)
            return;

        if (lower.type != BoundType.None && upper.type != BoundType.None) {
            String lowerDelimiter = lower.type == BoundType.Exclusive ? "]" : "[";
            String upperDelimiter = upper.type == BoundType.Exclusive ? "[" : "]";
            String error = String.format("O valor têm que estar entre %s%s, %s%s", lowerDelimiter, lower.value.toString(), upper.value.toString(), upperDelimiter);

            throw new UserInputValidationException(error);
        } else if (lower.type != BoundType.None) {
            throw oneSideLimitException(lower, "maior");
        } else if (upper.type != BoundType.None) {
            throw oneSideLimitException(lower, "menor");
        }
    }
}