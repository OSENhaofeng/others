// Playground - noun: a place where people can play

import UIKit

var array = ["one","two","three","four"]
for element in array {
    print(element)
}

var array2 = [1,2,3,4,5,6,7,8,9,10];

func example1(integers: NSArray) {
    
    var number:NSInteger = 0
    
    for element in integers{
    number += (element as! NSNumber).integerValue
    }
    print("Sum all array items: \(number)")
}

example1(array2)

func example2() -> NSMutableArray {
    
    let array = NSMutableArray()

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
    
    let array = example2()
    
    for var i = 0; i<array.count; i++ {
        if ((array.objectAtIndex(i) as! Int % 2) == 0){
        array.removeObjectAtIndex(i)
        }
    }
    
    //print pair items from array
    example1(array)
}

//inferred types
func getClassName(obj : AnyObject) -> String {
    let objectClass : AnyClass! = object_getClass(obj)
    let className = objectClass.description()
    
    return className
}

let swiftArray = [1, 2, 3]
let swiftDictionary = ["Name": "John Doe"]
let cocoaArray : NSArray = [10, 20, 30]
var mutableCocoaArray = NSMutableArray()

var 🤔 = 5
var cadena = "hola"

print(getClassName(swiftArray))
print(getClassName(swiftDictionary))
print(getClassName(cocoaArray))
print(getClassName(mutableCocoaArray))
print(getClassName(🤔))
print(getClassName(cadena))
print(🤔.description)
