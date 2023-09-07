package aula08.Ex1;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        Empresa empresa = new Empresa("Viaturas de POO", "3810-193", "viaturas@poo.pt");

        System.out.println(empresa);

        empresa.addViatura(new Motociclo("00-AA-00", "Hmm", "POO", 100, TipoMotociclo.Estrada));
        empresa.addViatura(new Ligeiro("00-00-AA", "Renault", "POO", 100, "A0000000000000000", 200));
        empresa.addViatura(new Taxi("90-00-AB", "Fake", "POO", 100, "A0000000000000000", 200, 200));
        empresa.addViatura(new PesadoMercadorias("AA-00-00", "Ford", "POO", 1000, "A0B1C2D3E4F5G6H7I", 3500, 7000));
        empresa.addViatura(new PesadoPassageiros("AA-00-AA", "Bus", "POO", 1000, "A0B1C2D3E4F5G6H7I", 5000, 10));

        System.out.println(empresa);

        for (int i = 0; i < 20; i++) {
            List<Viatura> viaturas = empresa.getViaturas();
            int index = utils.Random.randomIntRange(0, viaturas.size() - 1);
            int trajeto = utils.Random.randomIntRange(0, 200);
            viaturas.get(index).trajeto(trajeto);
        }

        empresa.addViatura(new LigeiroEletrico("AA-00-00", "Ford", "POO", 1000, "A0B1C2D3E4F5G6H7I", 3500, 100, 1000));

        PesadoPassageirosEletrico ppe = new PesadoPassageirosEletrico("AA-00-AA", "Bus", "POO", 1000,
                "A0B1C2D3E4F5G6H7I", 5000,
                10, 80, 2000);

        ppe.trajeto(400);
        assert ppe.getCarga() == 60;

        empresa.addViatura(ppe);

        System.out.println(empresa);

        Viatura viaturaMaisUsada = null;

        for (Viatura viatura : empresa.getViaturas()) {
            if (viaturaMaisUsada == null) {
                viaturaMaisUsada = viatura;
                continue;
            }

            if (viatura.distanciaTotal() > viaturaMaisUsada.distanciaTotal())
                viaturaMaisUsada = viatura;
        }

        if (viaturaMaisUsada != null)
            System.out.printf("A viatura mais usada é (%d km): %s\n", viaturaMaisUsada.distanciaTotal(),
                    viaturaMaisUsada);

        try {
            System.out.println("A tentar criar matrícula nula");
            new PesadoPassageiros(null, "Bus", "POO", 1000, "A0B1C2D3E4F5G6H7I", 5000, 10);
            System.out.println("FALHOU");
        } catch (IllegalArgumentException e) {
            System.out.println("PASSOU, exceção capturada: " + e.getMessage());
        }

        try {
            System.out.println("A tentar criar matrícula inválida");
            new PesadoPassageiros("AA-AA-AA", "Bus", "POO", 1000, "A0B1C2D3E4F5G6H7I", 5000, 10);
            System.out.println("FALHOU");
        } catch (IllegalArgumentException e) {
            System.out.println("PASSOU, exceção capturada: " + e.getMessage());
        }

        try {
            System.out.println("A tentar criar marca nula");
            new PesadoPassageiros("AA-00-AA", null, "POO", 1000, "A0B1C2D3E4F5G6H7I", 5000, 10);
            System.out.println("FALHOU");
        } catch (IllegalArgumentException e) {
            System.out.println("PASSOU, exceção capturada: " + e.getMessage());
        }

        try {
            System.out.println("A tentar criar marca inválida");
            new PesadoPassageiros("AA-00-AA", "", "POO", 1000, "A0B1C2D3E4F5G6H7I", 5000, 10);
            System.out.println("FALHOU");
        } catch (IllegalArgumentException e) {
            System.out.println("PASSOU, exceção capturada: " + e.getMessage());
        }

        try {
            System.out.println("A tentar criar modelo nulo");
            new PesadoPassageiros("AA-00-AA", "Bus", null, 1000, "A0B1C2D3E4F5G6H7I", 5000, 10);
            System.out.println("FALHOU");
        } catch (IllegalArgumentException e) {
            System.out.println("PASSOU, exceção capturada: " + e.getMessage());
        }

        try {
            System.out.println("A tentar criar modelo inválido");
            new PesadoPassageiros("AA-00-AA", "Bus", "", 1000, "A0B1C2D3E4F5G6H7I", 5000, 10);
            System.out.println("FALHOU");
        } catch (IllegalArgumentException e) {
            System.out.println("PASSOU, exceção capturada: " + e.getMessage());
        }

        try {
            System.out.println("A tentar criar potência inválida");
            new PesadoPassageiros("AA-00-AA", "Bus", "POO", 0, "A0B1C2D3E4F5G6H7I", 5000, 10);
            System.out.println("FALHOU");
        } catch (IllegalArgumentException e) {
            System.out.println("PASSOU, exceção capturada: " + e.getMessage());
        }

        try {
            System.out.println("A tentar criar número de quadro nulo");
            new PesadoPassageiros("AA-00-AA", "Bus", "POO", 1000, null, 5000, 10);
            System.out.println("FALHOU");
        } catch (IllegalArgumentException e) {
            System.out.println("PASSOU, exceção capturada: " + e.getMessage());
        }

        try {
            System.out.println("A tentar criar número de quadro inválido");
            new PesadoPassageiros("AA-00-AA", "Bus", "POO", 1000, "A0B1C2D3E4F5G6H7", 5000, 10);
            System.out.println("FALHOU");
        } catch (IllegalArgumentException e) {
            System.out.println("PASSOU, exceção capturada: " + e.getMessage());
        }

        try {
            System.out.println("A tentar criar peso inválido");
            new PesadoMercadorias("AA-00-AA", "Bus", "POO", 1000, "A0B1C2D3E4F5G6H7I", 3499, 10);
            System.out.println("FALHOU");
        } catch (IllegalArgumentException e) {
            System.out.println("PASSOU, exceção capturada: " + e.getMessage());
        }

        try {
            System.out.println("A tentar criar capacidade de Passageiros inválida");
            new PesadoPassageiros("AA-00-AA", "Bus", "POO", 1000, "A0B1C2D3E4F5G6H7I", 3499, 8);
            System.out.println("FALHOU");
        } catch (IllegalArgumentException e) {
            System.out.println("PASSOU, exceção capturada: " + e.getMessage());
        }
    }
}
