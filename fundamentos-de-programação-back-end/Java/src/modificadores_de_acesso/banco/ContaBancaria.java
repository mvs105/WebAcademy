package banco;

public class ContaBancaria {

    // 1. DEFAULT ou PACKAGE-PRIVATE
    String titular; 

    // 2. PRIVATE
    private double saldo; 

    // 3. PROTECTED
    protected String tipoConta;

    // 4. PUBLIC     
    //Getter
    public double getSaldo() { 
        return this.saldo;
    }
    
    //Setter
    public void depositar(double valor) { 
        if (valor > 0) {
            this.saldo += valor;
            System.out.println("Depósito de R$" + valor + " realizado com sucesso.");
        } else {
            System.out.println("Erro: Valor de depósito inválido!");
        }
    }

    //Construtor
    public ContaBancaria(String titular, String tipoConta) {
        this.titular = titular;
        this.tipoConta = tipoConta;
        this.saldo = 0.0;
    }
}