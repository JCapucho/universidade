package Bloco1;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

public class Main {
    public static void main(String[] args) {
        final Tokenizer tokenizer = new Tokenizer(new BufferedReader(new InputStreamReader(System.in, StandardCharsets.UTF_8)));

        try {
            Token token = tokenizer.nextToken();
            while (token != null) {
                System.out.println(token);
                token = tokenizer.nextToken();
            }
        } catch(IOException e) {
            System.out.println(e.getMessage());
        }
    }
}
