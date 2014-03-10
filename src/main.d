module ExplMain;

import CsvParse;
import Cruscal;

import std.stdio;

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
	Link[] data = packData(rawData);
	setN(rawData.length);
	foreach(i;rawData)
		writeln(i); 
	writeln("======================================");
	Link[] path = cruscal(data);
	checkPath(path);
	foreach(l;path)
		writeln("(",l.from+1,",",l.to+1,")\t->\t",l.value);
	return 0;
}