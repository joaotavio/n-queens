package nqueens;

public class NRainhas {
    
    /*
    *   A posição i do vetor indica a coluna da rainha e o valor na posição i
    *   inidica a linha
    */
    private int[] tabuleiro;
    private int N = 8;
    private int num_solucoes;
    private boolean hab_print;
    
    public NRainhas(int n){
        this.N = n;
        tabuleiro = new int[N];
        num_solucoes = 0;
        hab_print = false;
    }
    
    public void executar(){
        executar(0);
        System.out.println("\nNúmero de soluções: "+num_solucoes);
    }
    
    public void executar(int col){
        for (int i = 0; i < N; i++) {
            if (seguro(i, col)){
                tabuleiro[col] = i;
                if (col == N-1){
                    num_solucoes++;
                    if (hab_print){
                        printSolucao();
                    }
                }
                else {
                    executar(col+1);
                }
            }
        }
    }
    
    /*
    *   Verifica se é seguro colocar uma nova rainha na posição linha, coluna
    */
    public boolean seguro(int linha, int coluna){
        for (int i = 0; i < coluna; i++) {
            //verifica ataque na linha
            if (tabuleiro[i] == linha){
                return false;
            }
            //verifica ataque nas diagonais
            if (Math.abs(tabuleiro[i] - linha) == Math.abs(i - coluna)){
                return false;
            }
        }
        return true;
    }
    
    public void habilitarPrint(boolean print){
        hab_print = print;
    }
    
    private void printSolucao(){
        System.out.println("\nSOLUÇÃO: ");
        for (int i = 0; i < N; i++) {
            System.out.print("|");
            for (int j = 0; j < N; j++) {
                if (i == tabuleiro[j]){
                    System.out.print(" Q ");
                }
                else {
                    System.out.print(" . ");
                }
            }
            System.out.println("|");
        }
        System.out.println();
    }
}
