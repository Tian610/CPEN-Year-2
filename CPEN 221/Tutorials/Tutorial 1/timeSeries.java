import java.util.ArrayList;
import java.util.Collections;

public class timeSeries {

    ArrayList<TimeSeriesEntry> entryList = new ArrayList<TimeSeriesEntry>();

    public boolean add(TimeSeriesEntry e) {
        for(int i = 0; i < entryList.size(); i++) {
            if(entryList.get(i).getTime == e.getTime()) {
                return false;
            } 
        }

        entryList.add(e);
        return true;
    }

    public timeSeriesEntry get(long t, long delta) {
        long bestDelta = delta;
        long currentDelta;
        long bestEntry = 0;
        
        for(int i = 0; i < entryList.size(); i++) {
            currentDelta = Math.abs(entrylist.get(i).getTime() - (time+delta));

            if(currentDelta < bestDelta) {
                bestDelta = currentDelta;
                bestEntry = i;

            } else if (currentDelta = bestDelta) {
                if(entryList.get(i).getTime > entryList.get(bestEntry).getTime) {
                    bestDelta = currentDelta;
                    bestEntry = i;
                }
            }

        }

        if(bestDelta == delta) {
            //throw exception here
        }

        return entryList.get(bestEntry);
    }
}
