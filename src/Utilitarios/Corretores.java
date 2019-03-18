
package Utilitarios;

public class Corretores {
    
    public static String ConverterParaAmericano(String Data){
        // convertendo para yyyy/MM/dd
        return Data.substring(6, 10) + "-" + Data.substring(3, 5) + "-" + Data.substring(0, 2);
    }

    public static String ConverterParaBrasileiro(String Data){
        // convertendo para yyyy/MM/dd
        return Data.substring(8, 10) + "-" + Data.substring(5, 7) + "-" + Data.substring(0, 4);
    }

    // serve para verificar se as funçoes converter datas estao trabalhando corretamente
    public static void main(String args[]){
        System.out.println(Corretores.ConverterParaAmericano("17/03/2019"));
        System.out.println(Corretores.ConverterParaBrasileiro("2019/03/17"));
    }
    
}
