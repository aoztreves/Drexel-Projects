//Aslan Oztreves
//11/18/2016



import java.io.*;

public class gInt {
	int a = 0;
	int b = 0;
	public gInt( int r )
	{
		a = r;
	}
	public gInt( int r, int i )
	{
		a = r;
		b = i;
	}
	public int imag()
	{
		return b;
	}
	public int real()
	{
		return a;
	}
	public gInt add( gInt rhs )
	{
		//(a+c) + (b+d) i.
		gInt sum = new gInt(( a + rhs.real() ) , ( b + rhs.imag() ));
		return sum;
	}
	public gInt multiply( gInt rhs )
	{
		//(ac-bd) + (ad+bc) i.
		gInt product = new gInt( (a * rhs.real()) - (b * rhs.imag()) , ( (a * rhs.imag()) + (b * rhs.real())));
		return product;
	}
	public float norm()
	{
		return (float)(Math.sqrt( (a*a) + (b*b) ));
	}


}

