package tutorials.tutorial1;

import java.util.ArrayList;
import java.util.Collections;

public class timeSeries {

    ArrayList<timeSeriesEntry> entryList = new ArrayList<TimeSeriesEntry>();

   
    public boolean add(TimeSeriesEntry e) {
        for(int i = 0; i < entryList.size(); i++) {
            if(entryList.get(i).getTime == e.getTime()) {
                return false;
            } 
        }

        entryList.add(e);
        return true;
    }

     /*
     * Adds a given TimeSeriesEntry to the TimeSeries. 
     * 
     * @param t Timestamp
     * @param delta Margin of Error
     */
    public timeSeriesEntry get(long t, long delta) {
        long bestDelta = Math.abs(entrylist.get(0).getTime() - (time+delta));
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

        if(bestDelta > delta) {
            //throw exception here
        }

        return entryList.get(bestEntry);
    }

    public boolean delete(long t) {
        for(int i = 0; i < entryList.size(); i++) {
            if(entryList.get(i).getTime == t) {
                entryList.remove(i);
                return true;
            }
        }
        
        return false;
    }


}
