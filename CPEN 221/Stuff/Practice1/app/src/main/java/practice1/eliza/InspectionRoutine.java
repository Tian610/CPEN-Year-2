package eliza;

public class InspectionRoutine {

    /**
     * Compute the number of times an artifact is inspected given a command sequence
     *
     * @param numArtifacts the number of artifacts in the museum, {@code numArtifacts > 0}
     * @param commands the commands for one iteration of inspections, {@code commands.length > 0}
     * @param repetitions the number of times the commands are to be repeated, {@code repetitions > 0}
     * @return the number of times each artifact is inspected
     *         (the entry at index i represents the number of times artifact i is inspected)
     */
    public static int[] inspectionCount(int numArtifacts, int[] commands, int repetitions) {
        int[] inspectList = new int[numArtifacts];
        int currentIndex = 0;
        inspectList[0]++;

        for (int i = 0; i < repetitions; i++) {
            for (int j = 0; j < commands.length; j++) {
                currentIndex = (currentIndex + commands[j]) % numArtifacts;
                inspectList[currentIndex]++;
            }
        }

        return inspectList;
    }

}
