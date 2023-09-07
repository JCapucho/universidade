package utils;

import java.util.function.Function;

/**
 * Adapter class that turns a function returning whether an input is valid or not into a validator
 */
class FunctionalValidator<T> implements InputValidator<T> {
    // The error message to be used if the input doesn't pass validation
    private String message;
    // The function that checks if the input is valid
    private Function<T, Boolean> predicate;

    /**
     * Constructs a new functional validator from a function that returns if an input is valid or not
     * and the error message that is used if the input isn't valid.
     *
     * @param predicate the function that will be used to determine if the input is valid or not
     * @param message   the error message used if the input isn't valid.
     */
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