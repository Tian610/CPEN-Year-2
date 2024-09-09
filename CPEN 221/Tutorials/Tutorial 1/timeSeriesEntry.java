public class timeSeriesEntry {

    public timeSeriesEntry(long t, double d) {
        double data = d;
        long time = t;
    }

    public long getTime() {
        return time;
    }

    public double getData() {
        return data;
    }
    
}
