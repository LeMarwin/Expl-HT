module Shortest;

import ExplMain;
import std.stdio;
import std.math;
import std.algorithm;
import std.exception;
import std.conv;

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

int[] closest(Link[] data)
{
	int[] path;
	int s=data[0].from;
	while(path.length<NODE_NUM)
	{
		auto buff = filterIfThere(pickAll(data,s),path,s);
		path~=s;
		if(buff.length!=0)
			s=getSecond(buff[0],s);
		else
			break;
	}
	return path;
}

Link[] pickAll(Link[] data,int a)
{
	Link[] res = [];
	for(int i=0;i<data.length;i++)
	{
		if((data[i].from==a)||(data[i].to==a))
		{
			res~=data[i];
		}
	}
	return res;
}

Link[] filterIfThere(Link[] data, int[] path, int origin)
{
	Link[] res = [];
	foreach(l;data)
	{
		if(!isThere(path,getSecond(l,origin)))
			res~=l;
	}
	return res;
}

int getSecond(Link l, int a)
{
	if(l.to==a)
		return l.from;
	if(l.from==a)
		return l.to;
	return -1;
}

bool isThere(int[] path, int a)
{
	foreach(l;path)
		if(l==a)
			return true;
	return false;
}


int getIndex(Link[] data, int a, int b)
{
	for(int i=0;i<data.length;i++)
		if((data[i].from==a)&&(data[i].to==b))
			return i;
	return 0;
}

double getValue(Link[] data, int a, int b)
{
	for(int i=0;i<data.length;i++)
		if((data[i].from==a)&&(data[i].to==b))
			return data[i].value;
	return 0;
}