package aula03;

import utils.Random;
import utils.UserInput;

public class Ex04 {
    public static void main(String[] args) {
        int alunos = UserInput.promptIntMin("Insira o número de alunos: ", 0, true);
        double[][] notas = new double[alunos][2];

        // Gerar as notas
        for (int i = 0; i < alunos; i++) {
            double notaT = Random.randomDoubleRange(0, 20);
            double notaP = Random.randomDoubleRange(0, 20);

            notas[i] = new double[]{notaT, notaP};
        }

        System.out.println(" NotaT  NotaP  Pauta");

        // Calcular e imprimir nota final
        for (int i = 0; i < alunos; i++) {
            double[] notasAluno = notas[i];
            double notaT = notasAluno[0];
            double notaP = notasAluno[1];

            double notaFinal = calcularNotaFinal(notaT, notaP);

            System.out.printf("%6.1f %6.1f %6.0f\n", notaT, notaP, notaFinal);
        }
    }

    private static double calcularNotaFinal(double notaT, double notaP) {
        if (notaT < 7 || notaP < 7) {
            return 66;
        }

        return 0.4 * notaT + 0.6 * notaP;
    }
}
