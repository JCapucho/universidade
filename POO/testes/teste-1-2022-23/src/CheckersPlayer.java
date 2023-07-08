package teste;

public class CheckersPlayer extends Player {
    private int elo;

    public CheckersPlayer(String nome, String clube) {
        super(nome, clube);
        this.elo = generateElo();
    }

    public int getElo() {
        return elo;
    }

    private static int generateElo() {
        return (int) (Math.random() * (50 - 1) + 1);
    }

    @Override
    public int matchWinner(Player other) {
        CheckersPlayer checkersOther = (CheckersPlayer) other;
        double rand = generateElo();

        if (rand < 0.8 * this.elo)
            return 1;
        else if (rand > this.elo + 0.2 * checkersOther.elo)
            return 2;
        else
            return 3;
    }

    @Override
    public String toString() {
        return super.toString() + "; Checkers; Elo: " + elo;
    }
}
