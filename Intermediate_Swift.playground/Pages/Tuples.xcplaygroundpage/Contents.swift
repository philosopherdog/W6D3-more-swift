//: [Previous](@previous)

import Foundation

/*:
 ### **Tuples**
 - Tuples are collection types (like Array, Dictionary, Set)
 - They group an arbitrary number of items of arbitrary types (like NSArray)
 - Like Arrays they are ordered, and accessible by index
 - They are also similar to dictionaries because they _can_ have keys/labels (But unlike dictionaries the labels are not proper data, like Strings)
 - Function parameters are actually tuples under the hood
 - They are handy for returning multiple values from functions (don't do this unless you really know why you need to do this!)
 - Don't use tuples for complex data structures. Use OBJECTS!
 - Question: How do you return more than 1 value from a method in objc?
 */
/*: ##### _Example 1:_ */
let tuple1 = ("nuts", "figs", 15) // (String, String, Int)
//: Access them using their index:
tuple1.0
tuple1.1
tuple1.2

//: You can bind the elements of a tuple into separate constants or variables to access them:

let (fats, fruit, _) = tuple1 // "_" ignores the 3rd value
fats
fruit

var (fats2, _, quantity) = tuple1
fats + " and seeds"
quantity
/*:
 ##### _Example 2:_
 You can also give them labels:
 */
// use let if readonly
var tuple2 = (lunch:"nuts", desert:"figs", quantity:15)
/*:
 Access using labels:
 */
tuple2.lunch
tuple2.desert
tuple2.quantity + 20 // it's a var

tuple2.lunch = "Pizza" // setting
tuple2.lunch // gets new value

/*:
 ##### _Do Step Through:_
 - Create a function that takes an array param.
 - The array contains 3 labeled tuples: age, height, and name (Int, Int, String).
 - Write a for loop that checks the age and height.
 - The first one that matches an age between 25 and 35 exclusive, and 182 and 192 inclusive (centementers) return the name
 - If there is no match return nil.
 */
func getNameForInput(input:[(age:Int, height: Int, name: String)]) -> String? {
    for i in input {
        if 25..<35 ~= i.age && 182...192 ~= i.height {
            return i.name
        }
    }
    return nil
}

let array = [(age:11, height:176, name:"Fred"), (age:25, height:182, name:"Jamie")]
getNameForInput(array)
/*:
 ##### _Do On Your Own:_
 
 - Create a function called fetchData that takes a _query_ parameter of _optional String_ type and returns a tuple of Int and optional String.
 - Using _guard let_ return status 404 and nil if the query param is nil
 - If the query string is not nil then return the tuple 200, and generate a random number between 0 and 1000 and return that as a string value
 */

//: [Next](@next)
