package stringchopping;

public class StringChopping {

    /**
     * Chop the specified segment of the given string <code>s</code>
     * @param s the string to chop
     * @param segment the segment of s to chop, and is one of: 'h' or 'H' for head, 'm' or 'M' for middle, 't' or 'T' for tail
     * @return the string after removing the specified segment from s
     */
    public static String chopString(String s, char segment) {

        int length = (int)Math.ceil(s.length()/3.0);
        segment = Character.toLowerCase(segment);
        
        String[] output = new String[3];

        output[0] = input.substring(0, length);
        output[1] = input.substring(length, input.length()-length);
        output[2] = input.substring(input.length()-length, input.length());

        if(segment=="h") {
            output[2] = "";

        } else if(segment=="m") {
            output[0] = "";

        } else if(segment=="t") {
            output[0] = "";
            
        }

        return output[0] + output[1] + output[2];
    }

    /**
     * Determine a chop sequence that will result in the provided string being 
     * cut down to the target character
     * @param s the string to dice
     * @param target the last character that should remain after a sequence of chop operations
     * @return a string that represents the sequence of chop operations needed to obtain exactly <code>target</code> and "no" if no such sequence exists
     */
    public static String diceStringTo(String s, char target) {
        
        int segmentLength = (int)Math.ceil(s.length()/3.0);
        String chopSequence = "";

        if(s.indexOf(target)<segmentLength) {
            chopSequence+= "T";
        } else if (s.indexOf(target) > s.length()-segmentLength) {
            chopSequence+= "H";
        } else if 


        return "";
    }

    /**
     * Obtain an array that contains all dice sequences for the given string,
     * with the first element of the array representing 'a' as the target
     * and the last element of the array representing 'z' as the target
     * @param s the string to dice
     * @return an array of dicing sequences for <code>s</code> 
     * with targets from 'a' to 'z', in that order
     */
    public static String[] allPossibleDicings(String s) {
        // TODO: Implement this method
        return null; // TODO: Change this
    }

}