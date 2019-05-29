//Aslan Oztreves
//11/18/2016

//import java.io.*;
import junit.framework.*;

public class gIntTest extends TestCase
{
	private gInt sum1 , sum2;
	private gInt pro1 , pro2;
	private gInt nn;

	public static Test suite()
	{
		return new TestSuite( gIntTest.class );
	}
	public gIntTest ( String name )
	{
		super(name);
	}
	protected void setUp()
	{
		sum1 = new gInt(3,2);
		sum2 = new gInt(1,3);
		pro1 = new gInt(3,2);
		pro2 = new gInt(2,3);
		nn = new gInt(5,2);
	}
	public void summationTest()
	{
		//first test
		gInt sumss = new gInt(2,1);
		assertNotNull(sumss);
		//second test
		gInt sums = sum1.add(sum2);
		assertNotNull(sums);
		//third test
		assertEquals(sums.real(), sumss.real());
		//fourth test
		assertEquals(sums.imag(), sumss.imag());
	}
	public void productionTest()
	{
		//first test
		gInt prodd = new gInt(3,3);
		assertNotNull(prodd);
		//second test
		gInt prod = pro1.multiply(pro2);
		assertNotNull(prod);
		//third test
		assertEquals(prod.real() , prodd.real());
		//fourth test
		assertEquals(prod.imag(), prodd.imag());
	}
	public void normTest()
	{
		//first test
		float normm = (float)(Math.sqrt(81));
		assertNotNull(normm);
		//second test
		float norm = nn.norm();
		assertNotNull(norm);
		//third test
		assertEquals(normm,norm);
	}
	public static void main()
	{
		String[] caseName = { gIntTest.class.getName() };
		junit.textui.TestRunner.main(caseName);
	}

}
