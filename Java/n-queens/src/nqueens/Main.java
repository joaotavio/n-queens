package nqueens;

public class Main {

    public static void main(String[] args) {
        NRainhas nrainhas = new NRainhas();
        long inicio = System.currentTimeMillis();
        nrainhas.executar();
        long fim = System.currentTimeMillis();
        System.out.println("Tempo de execução: "+(fim-inicio)+" ms");
    }
    
}
