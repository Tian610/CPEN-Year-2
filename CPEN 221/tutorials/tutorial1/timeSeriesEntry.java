public class TimeSeriesEntry {

    double data;
    long time;

    public TimeSeriesEntry(long t, double d) {
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
