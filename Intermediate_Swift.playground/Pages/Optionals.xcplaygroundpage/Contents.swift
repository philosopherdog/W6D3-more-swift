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

let result6 = Int(numString) // Int() Converts a String to Int?
print(result6)

/*:
 ##### _Do:_
 - write a conditional binding statement to unwrap result6
 */


/*: -------------------- */
/*:
 ##### **Forced UnWrap**
 - Everyone knows about forced unwrap
 - Use it when you absolutely expect a value there and the app cannot continue without it
 - Helpful in development because you want your app to crash in development if something unexpected is happening
 - But you might want to deal with missing data more gracefully in a production app
 - Avoid using forced unwrap just because you don't understand what's happening
 */

var valueMustBeThere: Int? = 12
valueMustBeThere!

/*:
 ##### _Do:_
 - rewrite the forced unwrap (above) in 3 distinct ways using a) a nil check, b) optional binding and c) guard. (Tip: comment out the forced unwrap version)
 */

// a) nil check

// b) optional binding

// c) guard



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

//: Nil Coalescing Replaces 2 more verbose techniques
//: 1. Long way
var result8 = ""
if let name = name {
    // name is unwrapped
    result8 = name
} else {
    // default value if name is nil
    result8 = "Slow Freddy"
}
result8

//: 2. Long way using basic ternary operator & nil checking
let result1 = name != nil ? name! : "Fat Freddy"
//: Nil coalescing (Sweet)
let result7 = name ?? "Slim Freddy"
/*:
 ###### _Example 2:_
 */
var age: Int? = 20

// ternary version
let result3 = age != nil ? age : 30
//: - Notice nil coalescing does implicit nil checking (try removing != nil from the ternary operator).
//: - Nil coalsecing implicitly uses the unwrapped optional if not nil.
// nil coalescing version
let result4 = age ?? 40

/*:
 ###### _Do:_
 Rewrite the long way using _guard_.
 */

/*: -------------------- */
/*:
 ##### **Optional Binding With Guard**
 
 - Prefer _guard let/var_ over _if let/var_
 - Guard is more intuitive since you test for _what you want_, not what you don't want
 - Guard gives an _early exit_
 - Guard puts the _Golden Path_ of your code outside brackets
 - Guard helps avoid the _pyramid of doom_
 - Guard makes code easier to reason about
 
 ##### _Example:_
 */
func isCatName(catName: String?) -> String {
    // nb. I'm making catName mutable, but remember it's a copy
    guard var catName = catName else {
        return "Cat name was nil!"
    }
    catName += " meow"
    return catName
}

isCatName(nil)
isCatName("Tashi")

/*:
 ##### _Do On Your Own:_
 Rewrite `isCatName(_:)` as `isCatName2(_:)` using the nil coalescing operator instead of guard
 */

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
myCell

//: I'm upcasting here (Look ma no _as_)
// Notice I don't need to:
// vanillaCell = myCell as? UITableViewCell
vanillaCell = myCell
print((vanillaCell?.textLabel?.text)!)

class Mammal {}

class Person: Mammal {
    var name: String?
}

class Dog: Mammal {}

//: Notice person is being implicitly upcast to an AnyObject! when I initialize it
let person: AnyObject = Person()
if person is Mammal {
    print("Person is a mammal")
}

//: because Person is an AnyObject the compiler cannot infer its underlying type so we can't use _as_ since this could return nil i.e. fail
//: you should force the cast, since we know person is a Mammal
let p2 = person as! Mammal

//: if you think the cast _could_ fail use as? instead, which returns an optional

let p3 = person as? Dog // if we forced downcast this would crash

p3 //: p3 is _not_ of type Dog

/*:
 ##### _Do On Your Own:_
 - Create another class Animate
 - Make Mammal a subclass of Animate
 - Write a new let _p4_ that does an optional cast of the person object to an Animate
 - Write an _if let_ that prints out a message showing that a person is indeed an Animate object
 */



/*: -------------------- */
/*:
 #### **Optional Chaining**
 - Is Shorthand for unwrapping optionals.
 - It overloads the `?`, which makes it a bit confusing.
 - It allows a nested expression to fail anywhere along the unwrapping
 - The whole expression either returns nil or an optional
 */



class Citizen {
    // not every citize has a libraryCard
    var libraryCard: LibraryCard?
}

class LibraryCard {
    let number: Int?
    // some library cards have no number? (use your imagination!)
    init(number:Int?) {
        self.number = number
    }
}

let citizen: Citizen?
citizen = Citizen()
let libraryCardNot = citizen?.libraryCard?.number

libraryCardNot // nil

// Creating another one
let libraryCard = LibraryCard(number: 12)

let citizen2:Citizen? = Citizen()
citizen2?.libraryCard = libraryCard
let number = citizen2?.libraryCard?.number
number // NOTICE number is still an OPTIONAL even if the citizen2 and libraryCard both are not nil, otherwise number would be nil. The whole expression itself is still an optional. To force unwrap it you have to put brackets around the whole expression and use the bang operator

//: Why do we need optional chaining!?
//: citizen2.libraryCard?.number replaces the following mess!

var result9: Int?
if citizen2 != nil {
    if citizen2!.libraryCard != nil {
        result9 = citizen2!.libraryCard!.number
        print(result9)
    } else {
        result9 = nil
    }
} else {
    result9 = nil
}

print(result9)

// same thing with guard
/*
guard let citizen2 = citizen2 else {
    fatalError()
}

guard let libraryCard = citizen2.libraryCard else {
    fatalError()
}
 libraryCard.number
*/


// here it is using optional binding.

if let citizen2 = citizen2 {
    if let libraryCard = citizen2.libraryCard {
    print(libraryCard.number)
    }
}

// I can also drop the nesting and do it inline
if let citizen2 = citizen2, libraryCard = citizen2.libraryCard {
    print(libraryCard.number)
}


/*:
 ##### _Do On Your Own:_
 - vanillaCell?.textLabel?.text above is optional chaining.
 - Write this statement out long hand using != nil for each element and print the unwrapped text value
 */






