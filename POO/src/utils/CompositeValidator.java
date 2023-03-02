package utils;

/**
 * Validator that aggregates multiple validators in series
 */
class CompositeValidator<T> implements InputValidator<T> {
    // Validators to be applied
    private final InputValidator<T>[] validators;

    /**
     * Constructs a new composite validator from other validators
     *
     * @param validators the validators to be used when validating
     */
    public CompositeValidator(InputValidator<T>... validators) {
        this.validators = validators;
    }

    @Override
    public void apply(T t) throws UserInputValidationException {
        for (InputValidator<T> validator : validators)
            validator.apply(t);
    }
}
