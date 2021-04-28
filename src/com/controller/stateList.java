package com.controller;

import java.util.Arrays;

public class stateList {
int cluster;
int cases;
String state;
public int getCluster() {
	return cluster;
}
public void setCluster(int cluster) {
	this.cluster = cluster;
}
public int getCases() {
	return cases;
}
public void setCases(int cases) {
	this.cases = cases;
}
public String getState() {
	return state;
}
public void setState(String state) {
	this.state = state;
}
@Override
public String toString() {
	return "stateList [cluster=" + cluster + ", cases=" + cases + ", state=" + state + "]";
}

stateList(){
	cases = 0;
	cluster = 0;
	state = "West Bengal";
}
}
