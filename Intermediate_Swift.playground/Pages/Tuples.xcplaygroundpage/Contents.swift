//: [Previous](@previous)

import Foundation

/*:
 ### **Tuples**
 - Tuples are collection type (similar to Array, Dictionary, Set)
 - They group an arbitrary number of items of arbitrary types (like NSArray)
 - Like Arrays they are ordered, and accessible by index
 - They are also similar to dictionaries because they _can_ have keys/labels (But unlike dictionaries the labels are not proper data, like Strings)
 - Function parameters are actually tuples under the hood
 - They are handy for returning multiple values from functions (don't do this unless you really know why you need to do this!)
 - Don't use tuples for complex data structures. Use OBJECTS!
 - Question: How do you return more than 1 value from a method in Objc?
 */
/*: ##### _Example 1:_ */
let tuple1 = ("nuts", "figs", 15) // It's type is: (String, String, Int)
//: Access them using their index:
tuple1.0
tuple1.1
tuple1.2

//: You can bind the elements of a tuple into separate constants or variables to access them:

let (fats, fruit, _) = tuple1 // "_" ignores the 3rd value
print(#line, fats)
print(#line, fruit)

var (fats2, _, quantity) = tuple1
print(#line, fats + " and seeds")
print(#line, quantity)
/*:
 ##### _Example 2:_
 You can also give them labels:
 */
// use let if readonly
var tuple2 = (lunch:"nuts", desert:"figs", quantity:15)
/*:
 Access using labels:
 */
print(#line, tuple2.lunch)
print(#line, tuple2.desert)
print(#line, tuple2.quantity + 20) // it's a var

tuple2.lunch = "Pizza" // set
print(#line, tuple2.lunch) // get new value

/*:
 Example of a Function that returns a tuple
 */
func returnTwoValues()->(type:String, code:Int) {
    return (type:"Bad", code:404)
}

let result = returnTwoValues()
print(#line, result.type)
print(#line, result.code)

//: [Next](@next)
