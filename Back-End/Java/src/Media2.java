import java.util.Scanner;

public class Media2{
    public static void main(String[] args){
        @SuppressWarnings("resource")

        Scanner sc = new Scanner(System.in);

        double nota1 = sc.nextDouble();
        double nota2 = sc.nextDouble();
        double media = (nota1 + nota2)/2;
        
        if( media >= 7.0){
            System.out.println("Aprovado com média: " + media);
        }else if(media >= 5){
            System.out.println("Final");
        }else{
            System.out.println("Reprovado por média: " + media);
        }
    }
}