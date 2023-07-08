package aula11;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.text.Collator;
import java.util.Locale;
import java.util.Map;
import java.util.Scanner;
import java.util.TreeMap;

public class Ex01 {
    public static void main(String[] args) throws FileNotFoundException {
        // Use a collator as the comparator to ensure accentuated characters are
        // correctly sorted according to the portuguese layout.
        // This is slower than the standard unicode value compare.
        final Locale locale = new Locale("pt");
        final Collator collator = Collator.getInstance(locale);

        // Use a TreeMap to make sure the map is always sorted, use the collator
        // as the custom comparator.
        final Map<String, Map<String, Integer>> pairs = new TreeMap<>(collator);
        final Scanner input = new Scanner(new FileReader("words.txt"));

        input.useDelimiter("[ \\r\\t\\n.,:'‘’;?!\\-*{}=+&/()\\[\\]”“\"]+");

        String lastWord = null;

        while (input.hasNext()) {
            String word = input.next();

            if (word.length() > 2) {
                word = word.toLowerCase();

                if (lastWord != null) {
                    final Map<String, Integer> cPair = pairs.computeIfAbsent(lastWord,
                            _pairStart -> new TreeMap<>(collator));
                    cPair.compute(word, (_pairEnd, accum) -> accum != null ? accum + 1 : 1);
                }

                lastWord = word;
            }
        }

        for (Map.Entry<?, ?> cPair : pairs.entrySet()) {
            System.out.println(cPair.getKey() + "=" + cPair.getValue());
        }
    }
}
