package additionClosure;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.Rule;
import org.junit.rules.Timeout;

import java.util.Arrays;

public class AdditionClosureTest {

	@Rule
	public Timeout globalTimeout = Timeout.seconds(30);

	@Test
	public void test1() {
		assertEquals(true, AdditionClosure.isClosed(Arrays.asList(-1, 0, 1), 2));
	}

	@Test
	public void test2() {
		assertEquals(false, AdditionClosure.isClosed(Arrays.asList(-2, 3), 4));
	}

//	@Test
//	public void test3() {
//		assertEquals(true, AdditionClosure.isClosed(Arrays.asList(1, 1, 0), 2));
//	}

	@Test
	public void test4() {
		assertEquals(false, AdditionClosure.isClosed(Arrays.asList(1, 1), 3));
	}

	@Test
	public void test5() {
		assertEquals(true, AdditionClosure.isClosed(Arrays.asList(1, 1, 2), 2));
	}

	@Test
	public void test6() {
		assertEquals(true, AdditionClosure.isClosed(Arrays.asList(0, 1, 1, 2), 2));
	}

	@Test
	public void test7() {
		assertEquals(false, AdditionClosure.isClosed(Arrays.asList(0, 1, 100, 50, 50), 100));
	}

	@Test
	public void test8() {
		assertEquals(true, AdditionClosure.isClosed(Arrays.asList(0, 1, 100, 50, 50), 50));
	}

	@Test
	public void test9() {
		assertEquals(true, AdditionClosure.isClosed(Arrays.asList(7, 1, 2, 3, 4, 5, 6), 7));
	}

	@Test
	public void test10() {
		assertEquals(true, AdditionClosure.isClosed(Arrays.asList(11, 11), 11));
	}

	
	@Test
	public void test11() {
		assertEquals(true, AdditionClosure.isClosed(Arrays.asList(14, 15, 16, 17, 18, 19, 20), 7));
	}
}
