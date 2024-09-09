package tutorials.tutorial1;

public class timeSeriesEntry {

    double data;
    long time;

    public timeSeriesEntry(long t, double d) {
        data = d;
        time = t;
    }

    public long getTime() {
        return time;
    }

    public double getData() {
        return data;
    }
    
}
