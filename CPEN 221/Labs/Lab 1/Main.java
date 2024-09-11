import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import additionClosure.AdditionClosure;
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

        // String s = "ONION";

        // String[] x = StringChopping.allPossibleDicings(s);

        // for(int i = 0; i<x.length; i++) {
        //     System.out.println(x[i]);
        // }

        List<Integer> intList = new ArrayList<Integer>();
        Collections.addAll(intList = new ArrayList<Integer>(), 0,1,100,50,50);
        int n = 100;

        boolean a = AdditionClosure.isClosed(intList, n);
        System.out.println(a);
    }
}
