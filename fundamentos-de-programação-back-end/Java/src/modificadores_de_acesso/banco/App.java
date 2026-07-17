package banco;

public class App {
    public static void main(String[] args) {
        ContaBancaria minhaConta = new ContaBancaria("Arthur", "Corrente");
        
        // //1. Default
        // System.out.println("Titular: " + minhaConta.titular);    
        
        minhaConta.titular = "Marcos";

        // System.out.println("Titular: " + minhaConta.titular);
        
        //2. Private
        // System.out.println("Saldo: " + minhaConta.saldo); //Gera erro
        
        
        //3. Protected
        // System.out.println("Tipo de conta: " + minhaConta.tipoConta);
             

        //4. Público
        // System.out.println("Saldo: " + minhaConta.getSaldo());

        // minhaConta.depositar(100);
        // System.out.println("Saldo: " + minhaConta.getSaldo());

    }
}
