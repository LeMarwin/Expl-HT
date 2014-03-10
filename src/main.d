module ExplMain;

import CsvParse;
import Cruscal;

import std.stdio;

int MAX_NODES = 1000;

struct Link
{
	int from;
	int to;
	double value;
	this(int f, int t, double v)
	{
		from = f;
		to = t;
		value = v;
	}
}

int main()
{
	writeln("Raw data matrix");
	writeln("======================================");
	double[][] rawData = getData("testdata.csv");
	foreach(i;rawData)
		writeln(i); 
	writeln("======================================");
	cruscal(rawData);
	return 0;
}