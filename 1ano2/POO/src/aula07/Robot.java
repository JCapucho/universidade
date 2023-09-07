package aula07;

public class Robot extends Movable {
    private String id;
    private String type;
    private int goalsScored;

    public void makeGoal() {
        goalsScored += 1;
    }
}
