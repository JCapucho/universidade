package aula05;

import java.util.ArrayList;

public class RealEstate {
    private ArrayList<Imovel> imovels = new ArrayList<>();

    public void newProperty(String localidade, int quartos, int preco) {
        imovels.add(new Imovel(localidade, quartos, preco));
    }

    public void sell(int id) {
        Imovel imovel = getImovelById(id);

        if (imovel == null) {
            System.out.printf("Imóvel %d não existe\n", id);
            return;
        }

        System.out.printf("Imóvel %d vendido\n", id);

        imovel.setAvailable(false);
        imovel.setAuction(null, null);
    }

    public void setAuction(int id, DateYMD auctionStart, int days) {
        Imovel imovel = getImovelById(id);

        if (imovel == null) {
            System.out.printf("Imóvel %d não existe\n", id);
            return;
        }

        if (!imovel.isAvailable()) {
            System.out.printf("Imóvel %d não está disponível\n", id);
            return;
        }

        System.out.printf("Imóvel %d vendido\n", id);

        DateYMD auctionEnd = auctionStart.clone();

        for (int i = 0; i < days; i++)
            auctionEnd.increment();

        imovel.setAuction(auctionStart, auctionEnd);
    }

    private Imovel getImovelById(int id) {
        for (Imovel imovel : imovels) {
            if (id == imovel.getId())
                return imovel;
        }

        return null;
    }

    @Override
    public String toString() {
        String accum = "";
        for (Imovel imovel : imovels) {
            accum += imovel.toString();
            accum += "\n";
        }
        return accum;
    }
}
