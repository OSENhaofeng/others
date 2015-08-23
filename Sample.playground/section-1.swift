// Playground - noun: a place where people can play

import UIKit

var array = ["one","two","three","four"]for element in array {    println(element)
}


var array2 = [1,2,3,4,5,6,7,8,9,10];



func example1(integers: NSArray) {
    
    var number:NSInteger = 0
    
    for element in integers{
    number += (element as! NSNumber).integerValue
    }
    
    println("Sum all array items: \(number)")
    
    
}


example1(array2)




func example2() -> NSMutableArray {
    
    var array = NSMutableArray()

    
    for var i = 11; i<=20; i++ {
    array.addObject(i)
    
    }
    
    return array
    
}


var array3 = example2()
//show nsmutable array value sum
example1(array3)




//delete pair items from array
func example3()  {
    
    var array = example2()
    
    
    
    for var i = 0; i<array.count; i++ {
        if ((array.objectAtIndex(i) as! Int % 2) == 0){
        array.removeObjectAtIndex(i)
        }
    }
    
    //print pair items from array
    example1(array)
    
}



















