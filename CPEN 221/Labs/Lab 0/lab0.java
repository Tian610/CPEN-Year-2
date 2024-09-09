import java.lang.String;
import java.lang.Math;

public class lab0 {
    public static void main(String[] args) {

        System.out.print("\033[H\033[2J");  
        System.out.flush();  
        
        String str = "qwertyuiopasdfghjkl";
        String str1 = str.toLowerCase();
        String[] output = {"","",""};
        String outputString = "";

        for(char i = 'a'; i <= 'z'; i++) {
            
            str1 = str.toLowerCase();
            int length = (int)Math.ceil(str1.length()/3.0);
            outputString += i+": ";
            
            while(str1.length()>1) {

                stringChopper(output, str1, length);

                if(output[0].indexOf(i) != -1) {

                    outputString += "T";
                    output[2] = "";

                } else if(output[1].indexOf(i) != -1) {

                    outputString += "H";
                    output[0] = "";

                } else if(output[2].indexOf(i) != -1) {
                    
                    outputString += "H";
                    output[0] = "";
                    
                } else {
                    break;
                }

                str1 = output[0] + output[1] + output[2];
                //outputString += "("+str1+")";
                length = (int)Math.ceil(str1.length()/3.0);
            
            }
            
            if(str.indexOf(i) == -1) {
                outputString += "NO";
            }

            outputString += ", \n";

        }

        System.out.println(outputString);

    }

    public static void stringChopper(String[] output, String input, int length) {

        output[0] = input.substring(0, length);
        output[1] = input.substring(length, input.length()-length);
        output[2] = input.substring(input.length()-length, input.length());

    }

}