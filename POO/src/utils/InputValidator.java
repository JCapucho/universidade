package utils;

import java.util.function.Function;

@FunctionalInterface
public interface InputValidator<T> {
    void apply(T t) throws UserInputValidationException;

    static <R> InputValidator<R> functional(Function<R, Boolean> predicate, String message) {
        class FunctionalValidator<T> implements InputValidator<T> {
            private String message;
            private Function<T, Boolean> predicate;

            public FunctionalValidator(Function<T, Boolean> predicate, String message) {
                this.message = message;
                this.predicate = predicate;
            }

            @Override
            public void apply(T t) throws UserInputValidationException {
                if (!predicate.apply(t))
                    throw new UserInputValidationException(message);
            }
        }

        return new FunctionalValidator<>(predicate, message);
    }

    static <K> InputValidator<K> composite(InputValidator<K>... validators) {
        return new CompositeValidator<>(validators);
    }

    static <T extends Number & Comparable> InputValidator<T> minValidator(T min) {
        return minValidator(min, false);
    }

    static <T extends Number & Comparable> InputValidator<T> minValidator(T min, boolean minExclusive) {
        LimitBound<T> lower = LimitBound.fromBoolean(min, minExclusive);
        LimitBound<T> upper = LimitBound.none();
        return new LimitsValidator<>(lower, upper);
    }

    static <T extends Number & Comparable> InputValidator<T> maxValidator(T max) {
        return maxValidator(max, false);
    }

    static <T extends Number & Comparable> InputValidator<T> maxValidator(T max, boolean maxExclusive) {
        LimitBound<T> lower = LimitBound.none();
        LimitBound<T> upper = LimitBound.fromBoolean(max, maxExclusive);
        return new LimitsValidator<>(lower, upper);
    }

    static <T extends Number & Comparable> InputValidator<T> rangeValidator(T min, T max) {
        return rangeValidator(min, max, false, false);
    }

    static <T extends Number & Comparable> InputValidator<T> rangeValidator(T min, T max, boolean minExclusive, boolean maxExclusive) {
        LimitBound<T> lower = LimitBound.fromBoolean(min, minExclusive);
        LimitBound<T> upper = LimitBound.fromBoolean(max, maxExclusive);
        return new LimitsValidator<>(lower, upper);
    }
}