package practice1;
import eliza;
import eliza.InspectionRoutine;

public class Main {
    public static void main(String[] args) {

        System.out.print("\033[H\033[2J");  
        System.out.flush();  
        
        int[] inspectList = InspectionRoutine.inspectionCount(10, new int[]{1, 2, 3}, 3);
        for (int i = 0; i < inspectList.length; i++) {
            System.out.println(inspectList[i]);
        }
    }
}
