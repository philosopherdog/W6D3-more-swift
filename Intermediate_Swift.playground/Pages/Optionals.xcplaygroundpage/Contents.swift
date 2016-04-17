//: [Previous](@previous)

import UIKit

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

/*:
 ##### _Do:_
 - Create a function that takes an optional Int parameter, and returns an Int
 - If the argument passed in is nil then return -1
 - If the argument passed in is not nil then square it
 - Use guard to optionally bind the incoming parameter
 */

/*: -------------------- */
/*:
 ##### **Optional Casting**
 */

/*: Notice: Upcasting is implicit! */

var vanillaCell: UITableViewCell?

class MyCell: UITableViewCell {
}

let myCell = MyCell()
myCell.textLabel?.text = "My label"

vanillaCell = myCell
print(vanillaCell?.textLabel?.text)


class Mammal {}

class Person: Mammal {
    var name: String?
}

class Dog: Mammal {}

// Notice person is an AnyObject!
let person: AnyObject = Person()
if person is Mammal {
    print("Person is a mammal")
}

// because Person is an AnyObject the compiler cannot infer its underlying type so we can't use as
// you have to force the cast
let p2 = person as! Mammal

// if you think the cast could fail use as? instead

let p3 = person as? Dog

p3

/*:
 ##### _Do:_
 - Create another class Animate
 - Add Animate to the Mammal class as its subclass
 - Write a new let _p4_ that does an optional cast of the person object to an Animate
 - Write an _if let_ that prints out a message showing that a person is indeed an Animate object
 */

/*: -------------------- */
/*:
 #### **Optional Chaining**
 */


class Citizen {
    var libraryCard: LibraryCard?
}

class LibraryCard {
    let number: Int?
    init(number:Int?) {
        self.number = number
    }
}

let citizen: Citizen?
citizen = Citizen()
let libraryCardNot = citizen?.libraryCard?.number

libraryCardNot // nil

let libraryCard = LibraryCard(number: 12)

let citizen2 = Citizen()
citizen2.libraryCard = libraryCard
let number = citizen2.libraryCard?.number
print(number) // returns an optional if successful, otherwise nil


// citizen2.libraryCard?.number replaces the following nested mess!

if citizen2.libraryCard != nil {
    let card = citizen2.libraryCard!
    if card.number != nil {
        let num = card.number!
        print("Yay I finally got the number!")
    }
}


/*:
 ##### _Do:_
 - vanillaCell?.textLabel?.text above is optional chaining. 
 - Write this statement out long hand using != nil for each element and print the unwrapped text value















