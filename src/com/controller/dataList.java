package com.controller;

public class dataList {
int x;
int y;
dataList()
{}
public int getX() {
	return x;
}
public void setX(int x) {
	this.x = x;
}
public int getY() {
	return y;
}
public void setY(int y) {
	this.y = y;
}
public dataList(int x, int y) {
	super();
	this.x = x;
	this.y = y;
}
@Override
public String toString() {
	return "dataList [x=" + x + ", y=" + y + "]";
}

}
