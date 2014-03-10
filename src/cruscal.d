module Cruscal;

import ExplMain;
import std.stdio;
import std.math;
import std.algorithm;
import std.exception;

int[] p;
int[] rank;

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

Link[] cruscal(double[][] rawData)
{
	Link[] data = packData(rawData);
	Link[] path = [];
	p = [];
	rank = [];
	for(int i=0;i<rawData.length;i++)
	{
		p~=i;
		rank~=0;
		assert((p[i]==i)&&(rank[i]==0));
	}
	return [Link(1,2,3)];
}