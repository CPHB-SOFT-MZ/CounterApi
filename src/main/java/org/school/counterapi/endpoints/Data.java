/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.school.counterapi.endpoints;

/**
 *
 * @author Mikkel
 */
public class Data {
    public int data = Count.counter; 
    
    public void update(){
        data = Count.counter;
    }
}
