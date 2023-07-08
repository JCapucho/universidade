package teste;

public class ChessPlayer extends Player {
    private int elo;

    public ChessPlayer(String nome, String clube) {
        super(nome, clube);
        this.elo = generateElo();
    }

    public int getElo() {
        return elo;
    }

    private static int generateElo() {
        return (int) (Math.random() * (100 - 1) + 1);
    }

    @Override
    public int matchWinner(Player other) {
        ChessPlayer chessOther = (ChessPlayer) other;
        double rand = generateElo();

        if (rand < 0.8 * this.elo)
            return 1;
        else if (rand > this.elo + 0.2 * chessOther.elo)
            return 2;
        else
            return 3;
    }

    @Override
    public String toString() {
        return super.toString() + "; Chess; Elo: " + elo;
    }
}
