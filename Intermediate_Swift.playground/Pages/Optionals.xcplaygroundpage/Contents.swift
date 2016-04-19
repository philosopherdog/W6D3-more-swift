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
 - Everyone knows about forced unwrap
 - Use it when you absolutely expect a value there and the app cannot continue without it
 - Helpful in development, but you might want to deal with missing data more gracefully in a production app
 - Avoid using forced unwrap just because you don't understand what's happening
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

//: Replaces 2 options
//: 1. Long way
var result8 = ""
if let name = name {
    result8 = name
} else {
    name = "Slow Freddy"
}

//: 2. Long way using ternary
let result1 = name != nil ? name! : "Fast Freddy"

//: Nil coalescing (Sweet)
let result7 = name ?? "Slow Freddy"

/*:
 ###### _Example 2:_
 */
var age: Int?

let result3 = age != nil ? age : 30
result3

let result4 = age ?? 40
result4

/*:
 ###### _Do:_
 Rewrite long way 1. using guard.
 */

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
isCatName("Tashi")

/*:
 ##### _Do:_
 Rewrite `isCatName(_:)` using the nil coalescing operator
 */
var catName: String?
let result10 = catName ?? "Cat name was nil"

/*:
 ##### _Do:_
 - Create a function that takes an optional Int parameter, and returns an Int
 - If the argument passed in is nil then return -1
 - If the argument passed in is not nil then square it
 - Use guard to optionally bind the incoming parameter
 - Create a second version that using nil coalescing
 */
func f2(num: Int?) -> Int {
    guard let num = num else {
        return -1
    }
    return num * num
}

func f3(num:Int?) -> Int {
//    let result =
    return (num ?? -1) != -1 ? (num! * num!) : -1
}

f2(nil)
f3(12)
/*: -------------------- */
/*:
 ##### **Optional Casting**
 Notice: Upcasting is _implicit_!
 */

//: Example of implicit upcasting
var vanillaCell: UITableViewCell?

class MyCell: UITableViewCell {
}

let myCell = MyCell()
myCell.textLabel?.text = "My label"

//: I'm upcasting here (Look ma no _as_)
vanillaCell = myCell
print(vanillaCell?.textLabel?.text)

class Animate {
}
class Mammal:Animate {}

class Person: Mammal {
    var name: String?
}

class Dog: Mammal {}

//: Notice person is being implicitly upcast to an AnyObject!
let person: AnyObject = Person()
if person is Mammal {
    print("Person is a mammal")
}

//: because Person is an AnyObject the compiler cannot infer its underlying type so we can't use _as_ since this could return nil i.e. fail
//: you have to force the cast
let p2 = person as! Mammal

//: if you think the cast could fail use as? instead, which returns an optional

let p3 = person as? Dog

p3 //: Dog?

/*:
 ##### _Do:_
 - Create another class Animate
 - Make Mammal a subclass of Animate
 - Write a new let _p4_ that does an optional cast of the person object to an Animate
 - Write an _if let_ that prints out a message showing that a person is indeed an Animate object
 */
let p4 = person as? Animate
if let p4 = p4 {
    print("Person is indeed an Animate Object")
}
/*: -------------------- */
/*:
 #### **Optional Chaining**
 */


class Citizen {
    // not every citize has a libraryCard
    var libraryCard: LibraryCard?
}

class LibraryCard {
    let number: Int?
    // some library cards have no number? use your imagination.
    init(number:Int?) {
        self.number = number
    }
}

let citizen: Citizen?
citizen = Citizen()
let libraryCardNot = citizen?.libraryCard?.number

libraryCardNot // nil

let libraryCard = LibraryCard(number: 12)

let citizen2:Citizen? = Citizen()
citizen2?.libraryCard = libraryCard
let number = citizen2?.libraryCard?.number
print(number) // returns an optional if successful, otherwise nil

//: Why do we need optional chaining!?
//: citizen2.libraryCard?.number replaces the following mess!

var result9: Int?
if citizen2 != nil {
    if citizen2!.libraryCard != nil {
        if citizen2?.libraryCard!.number != nil {
            result9 = citizen2!.libraryCard!.number!
        } else {
            result9 = nil
        }
    } else {
        result9 = nil
    }
} else {
    result9 = nil
}

print(result9)


/*:
 ##### _Do:_
 - vanillaCell?.textLabel?.text above is optional chaining.
 - Write this statement out long hand using != nil for each element and print the unwrapped text value
 */
var text: String?
if vanillaCell != nil {
    if vanillaCell!.textLabel != nil {
        if vanillaCell!.textLabel!.text != nil {
            text = vanillaCell!.textLabel!.text
        } else {
            text = nil
        }
    } else {
        text = nil
    }
} else {
    text = nil
}




