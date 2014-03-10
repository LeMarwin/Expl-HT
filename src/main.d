module ExplMain;

import std.stdio;
import CsvParse;

struct Link
{
	int from;
	int to;
	int value;
}

int main()
{
	writeln("Gotta make homework!");
	double[][] rawData = getData("testdata.csv");
	Link data = packData(rawData);
	foreach(i;rawData)
		writeln(i); 
	return 0;
}