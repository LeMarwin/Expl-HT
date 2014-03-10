module ExplMain;

import CsvParse;
import Shortest;
import Cruscal;

import std.stdio;
import std.math;
import std.algorithm;

int NODE_NUM;

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

double sumPath(Link[] path)
{
	double sum = 0;
	foreach(l;path)
		sum+=l.value;
	return sum;
}

Link[] packData(double[][] raw)
{
	if(raw.length==0)
		throw new Exception("No data");
	if(raw.length!=raw[0].length)
		throw new Exception("Non-squared matrix");
	int N = raw.length; 
	Link[] packedData;
	for(int i=0;i<N;i++)
	{
		for(int j=0;j<=i;j++)
		{
			if((raw[i][j]==raw[j][i])||(isNaN(raw[i][j])&&isNaN(raw[j][i])))
			{
				if(!isNaN(raw[i][j]))
					packedData~=Link(j,i,raw[i][j]);
				else{}
			}
			else
				throw new Exception("Non-symmetric matrix");
		}
	}
	sort!("a.from<b.from")(packedData);
	sort!("a.value<b.value")(packedData);
	return packedData;
}

int main()
{
	double[][] rawData = getData("testdata.csv");
	Link[] data = packData(rawData);
	NODE_NUM = data.length;

	writeln("\nRaw data matrix");
	writeln("======================================");
	foreach(i;rawData)
		writeln(i); 
	writeln("======================================");

	writeln("\nArc\tvalue");
	writeln("--------------------------------------");
	foreach(l;data)
		writeln("(",l.from+1,",",l.to+1,")\t",l.value);
	writeln("======================================\n");

	writeln("\nKruskal algorithm:");
	Link[] cPath = cruscal(data);
	Link[] tempPath = cPath.dup;
	formatPath(cPath);
	if(tempPath.length==cPath.length)
		printPath(cPath,1);
	else
		printPath(tempPath,0);


	int[] pathClosest = closest(data);
	writeln("\nClosest first");
	write("Path:\t",pathClosest[0]+1);
	foreach(p;pathClosest[1..$])
		write("-",p+1);
	writeln("-",pathClosest[0]+1);

	writeln(calcValue(data, pathClosest));
	return 0;
}