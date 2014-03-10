module Cruscal;

import ExplMain;
import std.stdio;
import std.math;
import std.algorithm;
import std.exception;

int[] p;
int[] rank;
int N;

void setN(int n)
{
	N = n;
}

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

Link[] cruscal(Link[] data)
{
	//Link[] data = packData(rawData);
	Link[] path = [];
	p = [];
	rank = [];
	for(int i=0;i<N;i++)		//This is makeSet, actually;
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

void checkPath(Link[] path)
{
	int[N] temp;
	int a = 0;
	foreach(l;path)
	{
		temp[l.from]++;
		temp[l.to]++;
	}
	foreach(t;temp)
	{
		if(t==0)
			throw new Exception("Node with no links!");
		if(t==1)
			if(a<2)
				a++;
			else
				throw new Exception("3+ nodes with one link");
		if(t>2)
			throw new Exception("Node with 3+ links");
	}
}

string formatPath(Link[] path)
{
	return ";";
}