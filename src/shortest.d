module Shortest;

import ExplMain;
import std.stdio;
import std.math;
import std.algorithm;
import std.exception;
import std.conv;

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
	foreach(l;data)
	{
		if((l.to==a)&&(l.from==b))
			return l.value;
		if((l.to==b)&&(l.from==a))
			return l.value;
	}
	return 0;
}

double calcValue(Link[] data, int[] path)
{
	double sum = 0;
	for(int i=0;i<path.length-1;i++)
	{
		sum+=getValue(data,path[i],path[i+1]);
	}
	sum+=getValue(data,path[$-1],path[0]);
	return sum;
}