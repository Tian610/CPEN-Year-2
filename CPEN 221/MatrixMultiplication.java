import java.math.BigInteger;
import java.util.Arrays;
import java.util.stream.IntStream;

public class MatrixMultiplication
{
    final static BigInteger INTEGER_MAX_VALUE = BigInteger.valueOf(Integer.MAX_VALUE);
    final static BigInteger INTEGER_MIN_VALUE = BigInteger.valueOf(Integer.MIN_VALUE);

    /**
     * Multiplies two given matrices A and B
     *
     * @param A is the left matrix to be multiplied,
     *          has at least 1 entry,
     *          whose every entry < |sqrt(Integer.MAX_VALUE / A[0].length)|, and
     *          is not null
     * @param B is the right matrix to be multiplied,
     *          has at least 1 entry,
     *          whose every entry < |sqrt(Integer.MAX_VALUE / B.length)|, and
     *          is not null
     *
     * @throws IllegalArgumentException if number of columns in A is not equal to the number of rows in B, or if all the
     *                                  rows in either  matrix A or B do not have the same number of entries as the
     *                                  rest of the rows in that respective matrix
     *
     * @return the product of A and B, matrix AB
     */
    public static int[][] matrixMultiplyA(final int[][] A, final int[][] B)
    {
        if (A[0].length != B.length)
        {
            throw new IllegalArgumentException();
        }

        final int[][] AB = new int[A.length][B[0].length];
        final int[][] rowsOfA = new int[A.length][A[0].length];
        final int[][] colsOfB = new int[B[0].length][B.length];

        for(int i = 0; i < rowsOfA.length; i++)
        {
            rowsOfA[i] = A[i];
        }

        try
        {
            for(int j = 0; j < colsOfB.length; j++)
            {
                for(int k = 0; k < B.length; k++)
                {
                    colsOfB[j][k] = B[k][j];
                }
            }
        }
        catch (ArrayIndexOutOfBoundsException e)
        {
            throw new IllegalArgumentException();
        }


        for(int l = 0; l < rowsOfA.length; l++)
        {
            for (int t = 0; t < colsOfB.length; t++)
            {
                AB[l][t] = dotProduct(rowsOfA[l], colsOfB[t]);
            }
        }
        return AB;
    }

    /**
     * Multiplies two given matrices A and B
     *
     * @param A is the left matrix to be multiplied, and
     *          is not null
     * @param B is the right matrix to be multiplied, and
     *          is not null
     *
     * @throws IllegalArgumentException if number of columns in A is not equal to the number of rows in B, or if all the
     *                                  rows in either matrix A or B do not have the same number of entries as the
     *                                  rest of the rows in that respective matrix, or if either A or B has 0 entries
     * @throws ArithmeticException if an integer entry in product matrix AB overflows
     *
     * @return the product of A and B, matrix AB
     */
    static int[][] matrixMultiplyB(final int[][] A, final int[][] B)
    {

        if (A[0].length == 0 || B[0].length == 0 || A[0].length != B.length)
        {
            throw new IllegalArgumentException();
        }

        for (int i = 0; i < A.length; i++)
        {
            if (A[i].length != A[0].length)
            {
                throw new IllegalArgumentException();
            }
        }
        for (int i = 0; i < B.length; i++)
        {
            if(B[i].length != B[0].length){
                throw new IllegalArgumentException();
            }
        }

        final int[][] AB = new int[A.length][B[0].length];
        for(int i = 0; i < A.length; i++)
        {
            for(int j = 0; j < B[0].length; j++)
            {
                BigInteger dotProduct = BigInteger.valueOf(0);
                for(int k = 0; k < A[0].length; k++)
                {
                    BigInteger rowTerm = BigInteger.valueOf(A[i][k]);
                    BigInteger colTerm = BigInteger.valueOf(B[k][j]);
                    dotProduct = dotProduct.add(rowTerm.multiply(colTerm));
                }
                if (dotProduct.compareTo(INTEGER_MAX_VALUE) == 1 || dotProduct.compareTo(INTEGER_MIN_VALUE) == -1)
                {
                    throw new ArithmeticException();
                }
                AB[i][j] = dotProduct.intValue();
            }
        }
        return AB;
    }

    /**
     * Multiplies two given matrices A and B
     *
     * @param A is the left matrix to be multiplied,
     *          has at least 1 entry,
     *          whose every entry < |sqrt(Integer.MAX_VALUE / A[0].length)|,
     *          whose every row has the same number of elements as all other rows, and
     *          is not null
     * 
     * @param B is the right matrix to be multiplied,
     *          has at least 1 entry,
     *          whose every entry < |sqrt(Integer.MAX_VALUE / B.length)|,
     *          whose every row has the same number of elements, and
     *          whose every row has the same number of elements as all other rows, and
     *          is not null
     *
     * @return the product of A and B, matrix AB
     */
    public static int[][] matrixMultiplyC(final int[][] A, final int[][] B)
    {
        if (A[0].length == 0 || B[0].length == 0 || A[0].length != B.length)
        {
            throw new IllegalArgumentException();
        }
        /*
         * Adapted from https://stackoverflow.com/questions/34774384/how-to-multiply-2-double-matrices-using-streams
         */
        return Arrays.stream(A)
                .map(row -> IntStream.range(0, B[0].length)
                        .map(j -> IntStream.range(0, B.length)
                                .map(i -> row[i] * B[i][j]).sum())
                        .toArray())
                .toArray(int[][]::new);
    }

    /**
     * Multiplies two given matrices A and B
     *
     * @param A is the left matrix to be multiplied,
     *          has at least 1 entry,
     *          whose every entry < |sqrt(Integer.MAX_VALUE/A[0].length)|, and
     *          is not null
     * @param B is the right matrix to be multiplied,
     *          has at least 1 entry,
     *          whose every entry < |sqrt(Integer.MAX_VALUE/B.length)|, and
     *          is not null
     *
     * @throws an exception if number of columns in A is not equal to the number of rows in B, or if all the
     *                      rows in either matrix A or B do not have the same number of entries as the
     *                      rest of the rows in that respective matrix  
     *
     * @return the product of A and B, matrix AB
     */
    static int[][] matrixMultiplyD(final int[][] A, final int[][] B)
    {
        if(isIdentityMatrix(A))
        {
            return B;
        }

        if (isIdentityMatrix    (B))
        {
            return A;
        }

        return matrixMultiplyA(A, B);
    }

    /**
     * Computes the dot product of two vectors
     *
     * @param a is the first vector to multiply, and
     *          is not null
     * @param b is the second vector to multiply, and
     *          is not null
     *
     * @throws IllegalArgumentException if a and b are not of the same size
     * @return Euclidean inner product of vectors a and b
     */
    private static int dotProduct(final int[] a, final int[] b)
    {
        if (a.length != b.length)
        {
            throw new IllegalArgumentException();
        }
        int sum = 0;
        for(int i = 0; i < a.length; i++)
        {
            sum += a[i] * b[i];
        }
        return sum;
    }

    /**
     * Checks if a given matrix is an identity matrix
     *
     * @param mat is the matrix to test,
     *            every row has the same number of elements, and
     *            is not null
     *
     * @return true if mat is an identity matrix, and false otherwise
     */
    private static boolean isIdentityMatrix(final int[][] mat)
    {
        if (!(mat.length == mat[0].length))
        {
            return false;
        }
        for(int i = 0; i < mat.length; i++)
        {
            for(int j = 0; j < mat.length; j++)
            {
                if (i == j && mat[i][j] != 1)
                {
                    return false;
                }
                else if (i != j && mat[i][j] != 0)
                {
                    return false;
                }
            }
        }
        return true;
    }
}