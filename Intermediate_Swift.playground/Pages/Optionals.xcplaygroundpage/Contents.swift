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
var numString1 = "45t"
var numString2 = "45"


let result6 = Int(numString1) // Int() Converts a String to an optional Int (Int?)
let result66 = Int(numString2)
print(#line, result6)
print(#line, result66)

/*:
 ##### _Do:_
 - write a conditional binding statement to unwrap result6 or result66
 */

guard let result66 = result66 else {
    fatalError()
}

print(#line, result66)

/*: -------------------- */
/*:
 ##### **Forced UnWrap**
 - Everyone knows about forced unwrap
 - Use it when you absolutely expect a value there and the app cannot continue without it, like an outlet for instance
 - Helpful in development
 - You might want to deal with missing data more gracefully in a production app
 - Avoid using forced unwrap just because you don't understand what's happening. Stop. Try to figure it out.
 */

var valueMustBeThere: Int? = Int("12")
//valueMustBeThere!


/*:
 ##### _Do:_
 - rewrite the forced unwrap (above) in 3 distinct ways using a) a nil check, b) optional binding and c) guard. (Tips: comment out the forced unwrap version, and use fatalError() in the guard's else statement)
 - question: when should you use each version?
 */

// a) nil check
if valueMustBeThere != nil {
    print(#line, valueMustBeThere!)
}
// b) optional binding
if let valueMustBeThere = valueMustBeThere {
    print(#line, valueMustBeThere)
}
// c) guard

guard let valueMustBeThere = valueMustBeThere else {
    fatalError()
}



/*:
 * Common examples of when to use an optional
 */

// 1. To avoid dealing with an initializer
class MyViewController: UIViewController {
    var myVar: String!
    override func viewDidLoad() {
        myVar = "something"
    }
}

// 2. When an object could have a property that doesn't exist
class LibraryCard {
    let number:Int
    init(num:Int) {
        self.number = num
    }
}

class Person {
    // not all people have LibraryCards
    var libraryCard:LibraryCard?
    init(libraryCard:LibraryCard?) {
        self.libraryCard = libraryCard
    }
}

let p1 = Person(libraryCard: nil)

var myNum:Int? = 234
print(#line, myNum)

let p2 = Person(libraryCard: LibraryCard(num: myNum!))


/*: -------------------- */
/*:
 ##### **Nil Coalescing Operator:**
 - Unwraps an optional and if it resolves to nil, it provides a default value
 - Looks a bit like the ternary operator
 */
/*:
 ###### _Example 1:_
 */

var name: String?

//: Nil Coalescing Replaces 2 verbose techniques
//: 1. Basic long way

var result8 = ""
if let name = name {
    // name is unwrapped
    result8 = name
} else {
    // default value if name is nil
    result8 = "Slow Freddy"
}

print(#line, result8)

//: 2. Long way using ternary operator & nil checking
let result1 = name != nil ? name! : "Fat Freddy"
print(#line, result1)

//: Nil coalescing (Sweet)
let result7 = name ?? "Slim Freddy"
print(#line, result7)

/*:
 ###### _Example 2:_
 */
var age: Int? = 20

// ternary version
let result3 = age != nil ? age! : 30
print(#line, result3)
//: - Notice nil coalescing does implicit nil checking unlike the ternary operator (try removing != nil from the ternary operator).
//: - Nil coalescing implicitly uses the unwrapped optional if not nil.

// nil coalescing version
age = nil
let result4 = age ?? 40
print(#line, result4)


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
// vanillaCell = myCell as UITableViewCell
vanillaCell = myCell
print(#line, (vanillaCell?.textLabel?.text)!)

class Mammal {}

class Person2: Mammal {
    var name: String?
}

class Dog: Mammal {}

//: Notice person is being implicitly upcast to an AnyObject! when I initialize it
let person: AnyObject = Person2()
if person is Mammal {
    print(#line, "Person is a mammal")
}

//: because Person is an AnyObject the compiler cannot infer its underlying type so we can't use _as_ since this could return nil i.e. fail
//: you should force the cast, since we know person is a Mammal

let p22 = person as! Mammal
print(#line, p22)

//: if you think the cast _could_ fail use as? instead, which returns an optional

let p3 = person as? Dog // if we forced downcast this would crash

p3 //: p3 is _not_ of type Dog



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
    var libraryCard: LibraryCard2?
}

class LibraryCard2 {
    let number: Int?
    // some library cards have no number? (use your imagination!)
    init(num:Int?) {
        self.number = num
    }
}

let citizen: Citizen?
citizen = Citizen()
print(#line, citizen) // notice we can't do citizen? to unwrap!
print(#line, citizen?.libraryCard)
let libraryCardNot = citizen?.libraryCard?.number

libraryCardNot // nil

// Creating another one
let libraryCard = LibraryCard2(num: 12)

let citizen2:Citizen? = Citizen()
citizen2?.libraryCard = libraryCard
let number = citizen2?.libraryCard?.number
print(#line, number) // NOTICE number is still an OPTIONAL even if the citizen2 and libraryCard both are not nil. If citizen2 and libraryCard were nil then number would be nil. The whole expression itself is still an optional. To force unwrap it you have to put brackets around the whole expression and use the bang operator (!)
let number2 = (citizen2?.libraryCard?.number)!
print(#line, number2)

//: Why do we need optional chaining!?
//: citizen2.libraryCard?.number replaces the following mess using nil checking

var result9: Int?
if citizen2 != nil {
    if citizen2!.libraryCard != nil {
        result9 = citizen2!.libraryCard!.number
    } else {
        result9 = nil
    }
} else {
    result9 = nil
}
print(#line, result9)

// same thing with optional binding

if let citizen2 = citizen2 {
    if let libraryCard = citizen2.libraryCard {
        print(#line, libraryCard.number)
    }
}

// using list to avoid nesting!

if let citizen2 = citizen2, let libraryCard = citizen2.libraryCard {
    print(#line, libraryCard.number)
}


/*:
 ##### _Do On Your Own:_
 - vanillaCell?.textLabel?.text above (line 185?) is optional chaining.
 - Write this statement out long hand using nil checking for each element.
 - Next re-write out the optional chaining using optional binding both nested and flat.
 */






