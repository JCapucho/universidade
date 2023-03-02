package utils;

/**
 * Exception thrown by a validator when the input doesn't pass validation
 */
public class UserInputValidationException extends Exception {
    /**
     * Constructs a new UserInputValidationException with a message explaining
     * why the input wasn't valid.
     *
     * @param errorMessage the reason why the input wasn't valid
     */
    public UserInputValidationException(String errorMessage) {
        super(errorMessage);
    }
}
