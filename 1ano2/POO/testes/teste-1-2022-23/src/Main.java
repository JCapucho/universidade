package teste;

import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        TournamentManager chessTournament = new TournamentManager();
        TournamentManager checkersTournament = new TournamentManager();
        boolean tournamentStarted = false;
        Scanner scanner = new Scanner(System.in);
        String choice = "";

        while (!choice.equals("7")) {
            Player player;
            boolean isChess;

            System.out.println("TournamentManager Menu:");
            System.out.println("1. Add player");
            System.out.println("2. Remove player");
            System.out.println("3. Start game");
            System.out.println("4. New round");
            System.out.println("5. Search player");
            System.out.println("6. Print tournament(s) info");
            System.out.println("7. Exit");

            System.out.print("Enter choice: ");
            choice = scanner.nextLine();

            switch (choice) {
                case "1":
                    // adicionar um jogador
                    if (tournamentStarted) {
                        System.out.println("O torneio já começou, não são aceites novas candidaturas");
                        continue;
                    }

                    System.out.print("Insert the player's name: ");
                    String name = scanner.nextLine();
                    System.out.print("Insert the player's club: ");
                    String club = scanner.nextLine();

                    if (promptGameType(scanner))
                        chessTournament.addPlayer(new ChessPlayer(name, club));
                    else
                        checkersTournament.addPlayer(new ChessPlayer(name, club));

                    break;
                case "2":
                    isChess = promptGameType(scanner);

                    if (isChess)
                        player = promptFind(scanner, chessTournament);
                    else
                        player = promptFind(scanner, checkersTournament);

                    if (player == null) {
                        System.out.println("Nenhum jogador encontrado");
                        continue;
                    }

                    if (isChess)
                        chessTournament.removePlayer(player);
                    else
                        checkersTournament.removePlayer(player);

                    break;
                case "3":
                    // início do(s) torneio(s)
                    if (tournamentStarted)
                        System.out.println("O torneio já tinha começado");
                    else
                        System.out.println("O torneio começou");

                    tournamentStarted = true;

                    break;
                case "4":
                    // nova ronda
                    if (!tournamentStarted) {
                        System.out.println("O torneio ainda não começou");
                        continue;
                    }

                    System.out.println("Chess tournament: ");
                    if (!chessTournament.nextRound())
                        System.out.println("O torneio já concluiu");

                    System.out.println("Checkers tournament: ");
                    if (!checkersTournament.nextRound())
                        System.out.println("O torneio já concluiu");

                    break;
                case "5":
                    if (promptGameType(scanner))
                        player = promptFind(scanner, chessTournament);
                    else
                        player = promptFind(scanner, checkersTournament);

                    if (player == null) {
                        System.out.println("Nenhum jogador encontrado");
                        continue;
                    }

                    System.out.println(player);
                    break;
                case "6":
                    if (promptGameType(scanner))
                        chessTournament.printTournaments();
                    else
                        checkersTournament.printTournaments();
                    break;
                case "7":
                    System.out.println("Exiting program.");
                    break;
                default:
                    System.out.println("Opção inválida");
                    break;
            }
        }

        scanner.close();
    }

    // true if chess
    private static boolean promptGameType(Scanner scanner) {
        System.out.println("Player type:");
        System.out.println("1. Chess");
        System.out.println("2. Checkers");

        while (true) {
            System.out.print("Enter choice: ");
            String playerTypeChoice = scanner.nextLine();

            switch (playerTypeChoice) {
                case "1":
                    return true;
                case "2":
                    return false;
                default:
                    System.out.println("Opção inválida");
            }
        }
    }

    private static Player promptFind(Scanner scanner, TournamentManager tournament) {
        System.out.println("Search type:");
        System.out.println("1. By ID");
        System.out.println("2. By Name");

        while (true) {
            System.out.print("Enter choice: ");
            String playerTypeChoice = scanner.nextLine();

            switch (playerTypeChoice) {
                case "1":
                    System.out.print("Enter the id: ");
                    int ID = scanner.nextInt();
                    scanner.nextLine();
                    return tournament.searchForPlayer(ID);
                case "2":
                    System.out.print("Enter the name: ");
                    String name = scanner.nextLine();
                    return tournament.searchForPlayer(name);
                default:
                    System.out.println("Opção inválida");
            }
        }
    }
}
