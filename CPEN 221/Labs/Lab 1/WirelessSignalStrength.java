public class WirelessSignalStrength {

    /**
     * Determine the received signal strength when the wireless signal is transmitted over a given distance. The signal attenuation model is described by the polynomial that is represented using coefficients and exponents.
     * @param txSignalStrength the strength of the transmitted signal
     * @param distance the distance over which the signal is transmitted
     * @param exponents the exponents for the attenuation model polynomial
     * @param coefficients the coefficients for the attenuation model polynomial, coefficients.length == exponents.length
     * @return the received signal strength according to the provided model
     */
    public static double rss(double txSignalStrength, int distance, double[] exponents, double[] coefficients) {

        double sum = 0;

        for(int i = 0; i < exponents.length; i++) {
            sum += coefficients[i]*Math.pow(distance, exponents[i]);
        }

        return txSignalStrength*sum;
    }

}