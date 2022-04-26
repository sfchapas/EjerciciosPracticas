public with sharing class Utils {

    public static Boolean validarNIF(String NIF) {
        
        Integer NIFNumber = Integer.valueOf(NIF.substring(0, 8));
        Integer mod=0;   
        String miLetra='';
        List<String> letras=new List<String>{'T', 'R', 'W', 'A', 'G', 'M', 'Y', 'F', 'P', 'D', 'X', 'B', 'N', 'J', 'Z', 'S', 'Q', 'V', 'H', 'L', 'C', 'K', 'E' };
        
        mod = Math.mod(NIFNumber, 23);
        miLetra = letras[mod];

        if (miLetra == NIF.substring(8,9)) {
            System.debug('NIF '+NIF+' CORRECT');
            return true;
        }else {
            System.debug('NIF '+NIF+' INCORRECT');
            return false;
        } 
    }

    
}