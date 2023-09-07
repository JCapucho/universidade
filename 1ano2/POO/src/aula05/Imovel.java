package aula05;

import java.security.InvalidParameterException;

public class Imovel {
    private int id;
    private String localidade;
    private int quartos;
    private int preco;
    private boolean available = true;

    private DateYMD auctionStart;
    private DateYMD auctionEnd;

    private static int GLOBAL_ID = 1000;

    public Imovel(String localidade, int quartos, int preco) {
        this.id = GLOBAL_ID++;
        this.localidade = localidade;
        this.quartos = quartos;
        this.preco = preco;
    }

    public int getId() {
        return id;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public void setAuction(DateYMD auctionStart, DateYMD auctionEnd) {
        if ((auctionStart == null) != (auctionEnd == null))
            throw new InvalidParameterException("Ambas as datas devem ser nulas ou não nulas");

        this.auctionStart = auctionStart;
        this.auctionEnd = auctionEnd;
    }

    @Override
    public String toString() {
        String availableStr = this.available ? "sim" : "não";
        String accum = String.format("Imóvel: %d; quartos: %d; localidade: %s; preço: %d; disponível: %s", this.id, this.quartos, this.localidade, this.preco, availableStr);

        if (auctionStart != null && auctionEnd != null)
            accum += String.format(" leilão %s : %s", auctionStart, auctionEnd);

        return accum;
    }
}
