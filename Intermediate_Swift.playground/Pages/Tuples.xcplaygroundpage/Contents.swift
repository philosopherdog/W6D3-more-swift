//: [Previous](@previous)

import Foundation

/*:
### **Tuples**
- Tuples are collection types (like Array, Dictionary, Set)
- They group an arbitrary number of items of arbitrary types (like NSArray)
- Like Arrays they are ordered, and accessible by index
- They are also similar to dictionaries because they _can_ have keys/labels (But unlike dictionaries the labels are not proper data, like Strings)
- Function parameters are actually tuples under the hood
- They are handy for returning multiple values from functions (don't do this unless you know why you're doing it!)
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

let (fats, fruit, _) = tuple1 // "_" ignores the value
fats
fruit
/*: 
 ##### _Example 2:_
 You can also give them labels:
*/
// use let if readonly
var tuple2 = (lunch:"nuts", desert:"figs", cash:15)
/*: 
Access using labels:
*/
tuple2.lunch
tuple2.desert
tuple2.cash

tuple2.lunch = "Pizza" // setting/mutating
tuple2.lunch // gets new value

/*: 
 ##### _Do:_
 - Create a function that takes an array of 5 tuples, with age, height, and name (Int, Int, String).
 - Write a for loop that checks the first 2 elements.
 - The first one that matches 25, and 182 (centementers) return the name
 - If there is no match return nil.
*/

/*: 
 ##### _Do:_
 
 - Create a function called fetchData that takes a _query_ parameter of _optional String_ type.
 - Using _guard let_ return status 404 and nil if the query string is nil
 - If the query string is not nil then return 200, and generate a random number between 0 and 1000 and return that as the string value
*/

//: [Next](@next)
