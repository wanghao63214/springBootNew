package com.utils;

public class DemoUtils {
    public void main(String[] args){

    }

    public static int rec(int n){
        if(n == 0 || n == 1){
            return 1;
        }else{
            return n*rec(n-1);
        }
    }
}
