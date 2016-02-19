package nqueens;

public class Main {

    public static void main(String[] args) {
        // Parametro: Tamanho do tabuleiro NxN.
        NRainhas nrainhas = new NRainhas(8);
        
        /* Descomente a linha abaixo para habilitar o print das soluções.
        *  O tempo de CPU ficará prejudicado se o print estiver habilitado.
        */
        //nrainhas.habilitarPrint(true);     
        
        long inicio = System.currentTimeMillis();
        nrainhas.executar();
        long fim = System.currentTimeMillis();
        System.out.println("Tempo de execução: "+(fim-inicio)+" ms");
    }
    
}
