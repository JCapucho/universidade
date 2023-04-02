package aula07;

public class Movable {
    private int x;
    private int y;
    private double distance = 0;

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }

    public void move(int newX, int newY) {
        this.x = newX;
        this.y = newY;

        this.distance += Math.sqrt(newX * newX + newY * newY);
    }
}
