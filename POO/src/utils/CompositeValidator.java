package utils;

class CompositeValidator<T> implements InputValidator<T> {
    private final InputValidator<T>[] validators;

    public CompositeValidator(InputValidator<T>... validators) {
        this.validators = validators;
    }

    @Override
    public void apply(T t) throws UserInputValidationException {
        for (InputValidator<T> validator : validators)
            validator.apply(t);
    }
}
