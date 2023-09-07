package aula06;

import utils.DateYMD;
import utils.InputValidator;
import utils.UserInput;

import java.util.ArrayList;

public class Ex02 {
    private static ArrayList<Contacto> contactos = new ArrayList<>();

    public static void main(String[] args) {
        while (true) {
            System.out.println();
            int selection = UserInput.menuSelection(
                    "1 - Inserir contacto",
                    "2 - Alterar contacto",
                    "3 - Apagar contacto",
                    "4 - Procurar contacto",
                    "5 - Listar contactos",
                    "0 - Sair"
            );
            System.out.println();

            switch (selection) {
                case 0 -> {
                    return;
                }
                case 1 -> {
                    Pessoa pessoa = createPessoa();

                    if (pessoa == null) continue;

                    Contacto contacto;
                    while (true) {
                        String tele = UserInput.prompt("Insira o número de telemóvel: ");
                        String email = UserInput.prompt("Insira o email: ");

                        if (tele.matches("^\\s*$")) tele = null;
                        if (email.matches("^\\s*$")) email = null;

                        try {
                            contacto = new Contacto(pessoa, tele, email);
                            break;
                        } catch (IllegalArgumentException e) {
                            System.out.println(e);
                        }
                    }

                    contactos.add(contacto);
                }
                case 2 -> {
                    Contacto contacto = searchContacto();

                    if (contacto == null) continue;

                    while (true) {
                        try {
                            String tele = UserInput.prompt("Novo número de telemóvel (deixe vazio para não alterar): ");

                            if (!tele.matches("^\\s*$")) contacto.setTele(tele);

                            String email = UserInput.prompt("Novo email (deixe vazio para não alterar): ");

                            if (!email.matches("^\\s*$")) contacto.setEmail(email);

                            break;
                        } catch (IllegalArgumentException e) {
                            System.out.println(e);
                        }
                    }
                }
                case 3 -> {
                    Contacto contacto = searchContacto();

                    if (contacto == null) continue;

                    contactos.remove(contacto);
                }
                case 4 -> {
                    Contacto contacto = searchContacto();

                    if (contacto == null) continue;

                    System.out.println(contacto);
                }
                case 5 -> {
                    for (Contacto contacto : contactos) {
                        System.out.println(contacto);
                    }
                }
            }
        }
    }

    private static Pessoa createPessoa() {
        String nome = UserInput.promptValidator(
                "Insira o nome da pessoa: ",
                InputValidator.functional(v -> v.length() != 0, "O nome não pode esta vazio")
        );

        int cc = UserInput.promptIntMin("Insira o Cartão de cidadão: ", 1);

        for (Contacto contacto : contactos) {
            if (contacto.getPessoa().getCc() == cc) {
                System.out.println("Já existe um contacto com esta pessoa");
                System.out.println(contacto);
                return null;
            }
        }

        DateYMD dataNasc = UserInput.promptDate("Insira a data de nascimento");

        try {
            return new Pessoa(nome, cc, dataNasc);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
            return null;
        }
    }

    private static Contacto searchContacto() {
        ArrayList<Contacto> candidates = new ArrayList<>();

        int selection = UserInput.menuSelection(
                "1 - Procurar por nome",
                "2 - Procurar por número",
                "0 - Abortar"
        );

        switch (selection) {
            case 0 -> {
                return null;
            }
            case 1 -> {
                String searchNome = UserInput.prompt("Procura por nome: ");

                for (Contacto contacto : contactos) {
                    if (contacto.getPessoa().getName().contains(searchNome)) {
                        candidates.add(contacto);
                    }
                }
            }
            case 2 -> {
                String searchNumber = UserInput.prompt("Procura por número: ");

                for (Contacto contacto : contactos) {
                    if (contacto.getTele().startsWith(searchNumber)) {
                        candidates.add(contacto);
                    }
                }
            }
        }

        if (candidates.size() == 0) {
            System.out.println("Nenhum contacto encontrado");
            return null;
        } else if (candidates.size() == 1) {
            return candidates.get(0);
        } else {
            System.out.println("Multiple contacts found select one");

            for (Contacto candidate : candidates) {
                System.out.println(candidate);
            }

            while (true) {
                int idSelection = UserInput.promptIntMin("Insira a sua seleção: ", 1);

                for (Contacto candidate : candidates) {
                    if (candidate.getId() == idSelection) {
                        return candidate;
                    }
                }

                System.out.println("Invalid ID, please insert a valid ID");
            }
        }
    }
}
