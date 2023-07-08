package teste;

public interface ITournamentManager {
    public void addPlayer(Player player);

    public void removePlayer(Player player);

    public Player searchForPlayer(String nome);

    public Player searchForPlayer(int ID);

    public void printTournaments();

    public boolean nextRound();
    // returns false if tournament ended
}
