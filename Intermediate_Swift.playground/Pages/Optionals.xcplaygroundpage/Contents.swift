//: [Previous](@previous)

import Foundation

/*:
 ## **More Optionals**
 - - - - -
 * Basic Example
 * Forced Unwrap
 * Implicitly Unwrapped
 * Optional Binding (Using Guard)
 * Optional Chaining
 - - - - -
 */
/*:
##### **Basic Example:** */
var numString = "45"

let result6 = Int(numString) // Convert to Int?
print(result6)
/*: -------------------- */
/*:
##### **Forced UnWrap**
 - If a value must be there doing a forced unwrap will crash your app. Helpful in development, but you might want to remove in production
*/

var valueMustBeThere: Int? = 12
valueMustBeThere!

/*: -------------------- */
/*:
##### **Nil Coalescing Operator:**
 - Unwraps an optional and if nil it provides a default value
 - Looks a bit like the ternary operator
*/
/*:
###### _Example 1:_
*/

var name: String?

let result1 = name != nil ? name! : "Fast Freddy"

let result7 = name ?? "Slow Freddy"

/*:
###### _Example 2:_
*/
var age: Int?

let result3 = age != nil ? age : 30
result3

let result4 = age ?? 40
result4
/*: -------------------- */

/*: 
 ##### **Optional Binding With Guard**
 
- Prefer _guard let/var_ over _if let/var_
- Guard is more intuitive since you test for what you want, not what you don't want
- Guard gives an early exit
- Guard puts the _Golden Path_ of your code outside brackets
 
##### _Example:_
*/
func isCatName(catName: String?) -> String {
    guard let catName = catName else {
        return "Cat name was nil!"
    }
    return catName
}

isCatName(nil)

/*: ##### _Do:_ 
    - Create a function that takes an optional Int parameter, and returns an Int
    - If the argument passed in is nil then return -1
    - If the argument passed in is not nil then square it
    - Use guard to optionally bind the incoming parameter
*/











