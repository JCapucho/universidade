package aula09;

import java.util.*;

public class CollectionTester {
    public static void main(String[] args) {
        // Resultados:
        // ArrayList      Add   Search   Remove
        // 1000     0.45     5.23     0.77
        // 5000     0.40    12.36     1.42
        // 10000     0.71    35.47     4.25
        // 20000     1.49   158.68    12.75
        // 40000     0.82   473.37    39.89
        // 100000     1.48  2701.88   252.89
        //
        // LinkedList      Add   Search   Remove
        // 1000     0.31     3.65     0.60
        // 5000     0.41    36.97     0.13
        // 10000     0.18   134.73     0.66
        // 20000     0.30   562.78     0.31
        // 40000     0.53  2204.55     0.46
        // 100000     1.33 32348.07     5.10
        //
        // HashSet      Add   Search   Remove
        // 1000     0.15     0.15     0.31
        // 5000     0.50     0.22     0.18
        // 10000     0.58     0.60     0.33
        // 20000     1.21     1.19     0.68
        // 40000     2.46     1.99     1.12
        // 100000     6.32     4.39     1.96
        //
        // TreeSet      Add   Search   Remove
        // 1000     1.55     0.65     0.81
        // 5000     1.21     0.73     0.32
        // 10000     2.08     1.66     0.66
        // 20000     4.52     3.36     1.22
        // 40000     5.16     7.75     1.02
        // 100000     7.76    19.17     1.65
        final int[] DIMS_TO_TEST = {1000, 5000, 10000, 20000, 40000, 100000};

        System.out.println("ArrayList      Add   Search   Remove");

        for (final int DIM : DIMS_TO_TEST) {
            Collection<Integer> col = new ArrayList<>();
            final double[] times = checkPerformance(col, DIM);
            System.out.printf("%9d %8.2f %8.2f %8.2f\n", DIM, times[0], times[1], times[2]);
        }

        System.out.println();
        System.out.println("LinkedList      Add   Search   Remove");

        for (final int DIM : DIMS_TO_TEST) {
            Collection<Integer> col = new LinkedList<>();
            final double[] times = checkPerformance(col, DIM);
            System.out.printf("%9d %8.2f %8.2f %8.2f\n", DIM, times[0], times[1], times[2]);
        }

        System.out.println();
        System.out.println("HashSet      Add   Search   Remove");

        for (final int DIM : DIMS_TO_TEST) {
            Collection<Integer> col = new HashSet<>();
            final double[] times = checkPerformance(col, DIM);
            System.out.printf("%9d %8.2f %8.2f %8.2f\n", DIM, times[0], times[1], times[2]);
        }

        System.out.println();
        System.out.println("TreeSet      Add   Search   Remove");

        for (final int DIM : DIMS_TO_TEST) {
            Collection<Integer> col = new TreeSet<>();
            final double[] times = checkPerformance(col, DIM);
            System.out.printf("%9d %8.2f %8.2f %8.2f\n", DIM, times[0], times[1], times[2]);
        }
    }

    private static double[] checkPerformance(Collection<Integer> col, int DIM) {
        double start, stop, add, search, remove;
        // Add
        start = System.nanoTime(); // clock snapshot before
        for (int i = 0; i < DIM; i++)
            col.add(i);
        stop = System.nanoTime(); // clock snapshot after
        add = (stop - start) / 1e6; // convert to milliseconds
        // Search
        start = System.nanoTime(); // clock snapshot before
        for (int i = 0; i < DIM; i++) {
            int n = (int) (Math.random() * DIM);
            if (!col.contains(n))
                System.out.println("Not found???" + n);
        }
        stop = System.nanoTime(); // clock snapshot after
        search = (stop - start) / 1e6; // convert nanoseconds to milliseconds
        // Remove
        start = System.nanoTime(); // clock snapshot before
        Iterator<Integer> iterator = col.iterator();
        while (iterator.hasNext()) {
            iterator.next();
            iterator.remove();
        }
        stop = System.nanoTime(); // clock snapshot after
        remove = (stop - start) / 1e6; // convert nanoseconds to milliseconds
        return new double[]{add, search, remove};
    }
}
