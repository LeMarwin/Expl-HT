module ExplMain;

import std.stdio;
import CsvParse;

struct Link
{
	int from;
	int to;
	int value;
}

Link[] packData(double[][] raw)
{
	if(raw.length==0)
		
	if(raw.length!=raw[0])
}

int main()
{
	writeln("Gotta make homework!");
	double[][] rawData = getData("testdata.csv");
	Link[] data = packData(rawData);
	foreach(i;rawData)
		writeln(i); 
	return 0;
}