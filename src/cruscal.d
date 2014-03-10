module Cruscal;

import ExplMain;
import std.stdio;
import std.math;
import std.algorithm;
import std.exception;
import std.conv;

// 	Disjoit sets implementation
	int[] p;
	int[] rank;


	void makeSet(int x)
	{
		p[x] = x;
		rank[x] = 0;
	}

	int findSet(int x)
	{
		if(p[x]==x)
			return x;
		else
		{
			p[x]=findSet(p[x]);
			return p[x];
		}
	}

	void uniteSets(int a, int b)
	{
		if((a=findSet(a))==(b=findSet(b)))
			return;
		if(rank[a]<rank[b])
			p[a] = b;
		else
			p[b] = a;
		if(rank[a]==rank[b])
			++rank[a];
	}
/////////////////////////////////

//May have bugs
Link pickLink(ref Link[] path, int a)
{
	for(int i=0;i<path.length;i++)
	{
		if(path[i].from==a)
		{
			int b = path[i].to;
			path[i].from=-1;
			path[i].to=-1;
			return Link(a,b,path[i].value);
		}
		if(path[i].to==a)
		{
			int b = path[i].from;
			path[i].to=-1;
			path[i].from=-1;
			return Link(a,b,path[i].value);
		}
	}
	return Link(-1,-1,-1);
}

//Cruscal's algorithm
Link[] cruscal(Link[] data)
{
	Link[] path = [];
	p = [];
	rank = [];
	for(int i=0;i<NODE_NUM;i++)		//This is makeSet, actually;
	{
		p~=i;
		rank~=0;
		assert((p[i]==i)&&(rank[i]==0));
	}
	foreach(l;data)
	{
		if(findSet(l.from)!=findSet(l.to))
		{
			path~=l;
			uniteSets(l.from, l.to);
		}
	}
	return path;
}

//Sort path
void formatPath(ref Link[] path)
{
	int[] temp;
	for(int i=0;i<NODE_NUM;i++)
		temp~=0;
	int s=NODE_NUM+1;
	string res = "";
 	//Fill incidences
	foreach(l;path)
	{
		temp[l.from]++;
		temp[l.to]++;
	}
	//Find starting node
	for(int i=0;i<NODE_NUM;i++)
		if(temp[i]==1)
			if(i<s)
				s = i;
	Link buff = pickLink(path, s);	
	Link[] fPath=[];
	fPath~=buff;
	while(temp[buff.to]!=1)
	{
		buff = pickLink(path,buff.to);
		fPath~=buff;
	}
	path = fPath;
}

//Print path
void printPath(Link[] path, bool c)
{
	writeln("\nArc\tValue");
	writeln("--------------------------------------");
	string res = "";
	double sum = 0;
	res~=to!string(path[0].from+1);
	foreach(l;path)
	{
		res~="-"~to!string(l.to+1);
		writeln("(",l.from+1,",",l.to+1,")\t",l.value);
		sum+=l.value;
	}
	if(c)
		writeln("Path:\t",res);
	writeln("Value:\t",sum);
	writeln("======================================");
}