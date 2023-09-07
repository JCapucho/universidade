package teste;

import java.util.HashMap;
import java.util.Vector;

public class TournamentManager implements ITournamentManager {
    private Vector<Player> players = new Vector<>();
    private HashMap<Integer, Double> points = new HashMap<>();
    private int currentRound = 0;

    @Override
    public void addPlayer(Player player) {
        this.players.add(player);
    }

    @Override
    public void removePlayer(Player player) {
        this.players.remove(player);
        this.points.remove(player.getId());
    }

    @Override
    public Player searchForPlayer(String nome) {
        for (Player player : this.players) {
            if (player.getNome().equals(nome))
                return player;
        }

        return null;
    }

    @Override
    public Player searchForPlayer(int ID) {
        for (Player player : this.players) {
            if (player.getId() == ID)
                return player;
        }

        return null;
    }

    @Override
    public void printTournaments() {
        for (Player player : this.players) {
            double points = this.points.getOrDefault(player.getId(), 0.0);

            System.out.printf("%s; Points: %.1f\n", player, points);
        }
    }

    @Override
    public boolean nextRound() {
        int numPlayers = this.players.size();

        if (numPlayers == 0 || currentRound == numPlayers - 1)
            return false;

        for (int i = 1; currentRound + i < numPlayers; i++) {
            int p1Index = currentRound;
            int p2Index = currentRound + i;

            Player p1 = this.players.get(p1Index);
            Player p2 = this.players.get(p2Index);

            System.out.printf("Match %d (round %d): %s (%d) vs %s (%d)\n", i, currentRound, p1.getNome(), p1.getId(), p2.getNome(), p2.getId());

            double p1Points = points.getOrDefault(p1.getId(), 0.0);
            double p2Points = points.getOrDefault(p2.getId(), 0.0);

            switch (p1.matchWinner(p2)) {
                case 1:
                    System.out.printf("%s (%d) wins\n", p1.getNome(), p1.getId());
                    p1Points += 1;
                    break;
                case 2:
                    System.out.printf("%s (%d) wins\n", p2.getNome(), p2.getId());
                    p2Points += 1;
                    break;
                case 3:
                    System.out.printf("Draw\n");
                    p1Points += 1 / 2;
                    p2Points += 1 / 2;
                    break;
            }

            points.put(p1.getId(), p1Points);
            points.put(p2.getId(), p2Points);
        }

        currentRound++;

        return true;
    }
}
