package utils;

@FunctionalInterface
interface Comparator<T> {
    boolean apply(T value, T bound);
}

enum BoundType {
    None,
    Inclusive,
    Exclusive
}

final class LimitBound<T> {
    final T value;
    final BoundType type;

    private LimitBound(T value, BoundType type) {
        this.type = type;
        this.value = value;
    }

    static <K> LimitBound<K> none() {
        return new LimitBound<>(null, BoundType.None);
    }

    static <K> LimitBound<K> inclusive(K value) {
        return new LimitBound<>(value, BoundType.Inclusive);
    }

    static <K> LimitBound<K> exclusive(K value) {
        return new LimitBound<>(value, BoundType.Exclusive);
    }

    static <K> LimitBound<K> fromBoolean(K value, boolean exclusive) {
        return new LimitBound<>(value, exclusive ? BoundType.Exclusive : BoundType.Inclusive);
    }
}

final class LimitsValidator<T extends Number & Comparable> implements InputValidator<T> {
    private final LimitBound<T> lower;
    private final LimitBound<T> upper;

    public LimitsValidator(LimitBound<T> lower, LimitBound<T> upper) {
        this.lower = lower;
        this.upper = upper;
    }

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

    private UserInputValidationException oneSideLimitException(LimitBound<T> bound, String predicate) {
        String exclusivity = lower.type == BoundType.Inclusive ? "inclusivo" : "exclusivo";
        String error = String.format("O valor têm que ser %s que %s (%s)", predicate, bound.value.toString(), exclusivity);

        return new UserInputValidationException(error);
    }

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