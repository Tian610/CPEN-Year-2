import stringchopping.StringChopping;

public class Main {
    public static void main(String[] args) {

        System.out.print("\033[H\033[2J");  
        System.out.flush(); 

        // double s = 10;
        // int distance = 10;
        // double[] a = {5, 4};
        // double[] x = {-1, 0};


        // System.out.println("r = " + WirelessSignalStrength.rss(s,distance,x,a));

        String s = "ONION";

        String[] x = StringChopping.allPossibleDicings(s);

        for(int i = 0; i<x.length; i++) {
            System.out.println(x[i]);
        }
    }
}
