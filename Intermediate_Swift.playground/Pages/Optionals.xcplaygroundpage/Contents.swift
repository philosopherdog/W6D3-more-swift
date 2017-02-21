//: [Previous](@previous)

import UIKit
import PlaygroundSupport

// PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 ## **More Optionals**
 - - - - -
 * nil Checking.
 * Forced Unwrap.
 * Optional Binding (Using If and Guard).
 * Nil coalescing.
 * Optional Casting.
 * Failable init.
 * Optional Chaining.
 - - - - -
 */

/*:
 ##### **Question:**
 * What are some of the differences between Swift's nil and Objc's nil?
 */
/*:
 ##### **Basic Example:** */
var numString = "45l"

let result6 = Int(numString) // Int() Attempts to Convert a String to Int but it could fail

print(#line, result6 as Any)

/*:
 ##### Unwrapping
 - Think of optionals like boxed objects.
 - If you force unwrap an optional that is nil Swift will crash.
 - There are numerous ways to unwrap optionals in Swift and how you do this is important to readability.
 - Forced unwrapping.
 - Optional binding.
 - Nil Coalescing.
 - Implicit unwrapping.
 - Optional Chaining.
 */

/*: -------------------- */
/*:
 ##### **Forced UnWrap**
 - Everyone knows about forced unwrap.
 - Use it when you absolutely expect a value there and the app cannot continue without the value.
 - Helpful in development because you want your app to crash in development if something unexpected is happening.
 - But you will want to deal with missing data more gracefully in a production app!
 - Avoid using forced unwrap just because you don't understand what's happening.
 */

//Eg. Forced Unwrap
let nummy = Int("12")
nummy!

/*:
 ##### **Optional Binding**
 - There are 2 options:
 - `if let`
 - `guard let`
 - Use them when a nil value is possible.
 */

/*: -------------------- */
/*:
 ##### **Optional Binding With _if_**
 - Convenient syntax for unwrapping optionals.
 - Optional binding statements can be chained to avoid "the pyramid of doom".
 */

class LibraryCard {
  let number:Int
  init(num:Int) {
    self.number = num
  }
}

class Person {
  var libraryCard:LibraryCard?
  init(libraryCard:LibraryCard?) {
    self.libraryCard = libraryCard
  }
}

var p1 = Person(libraryCard: nil)

if let libCard = p1.libraryCard {
  print(#line, "this person has a library card!")
} else {
  print(#line, "this person doesn't have a library card.")
}

p1 = Person(libraryCard: LibraryCard(num: 1234))
if let libCard = p1.libraryCard {
  print(#line, "this person has a library card number ", libCard.number)
}

// chaining binding and conditional expressions
let newName = "fred"
if let libCard = p1.libraryCard, let myFavNum = Int("42"), newName == "fred" {
  print(#line, libCard.number, myFavNum)
}

/*: -------------------- */
/*:
 ##### **Optional Binding With Guard**
 
 - Prefer _guard let/var_ over _if let/var_.
 - Guard is more intuitive since you test for _what you want_, not what you don't want.
 - Guard gives an _early exit_.
 - Guard puts the _Golden Path_ of your code outside brackets.
 - Guard helps avoid the _pyramid of doom_.
 - Guard makes code easier to reason about.
 
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

isCatName(catName: nil)
isCatName(catName: "Tashi")


// chaining

guard let num1 = Int("44"), var num2 = Int("99") else {
  fatalError()
}
num1
num2+=1


/*: -------------------- */
/*:
 ##### _Defer:_
 * Provides a way to clean up whenever the function leaves the scope.
 * Defer avoids repeating cleanup code for each early exit.
 */

func testDefer(exit:Bool) {
  defer {
    print(#line, "runs whenever our function exits")
  }
  guard exit == false else{
    return
  }
  print(#line, "function got to the bottom")
}

testDefer(exit: false)

/*: -------------------- */
/*:
 ##### _Do:_
 Rewrite `isCatName(_:)` as `isCatName2(_:)` using the nil coalescing operator instead of guard
 */

//func isCatName2(catName: String?) -> String {
//  // nb. I'm making catName mutable, but remember it's a copy
//  guard var catName = catName else {
//    return "Cat name was nil!"
//  }
//  catName += " meow"
//  return catName
//}
//
//isCatName2(catName: nil)
//isCatName2(catName: "Tashi")

/*: -------------------- */
/*:
 ##### **Nil Coalescing Operator:**
 - Unwraps an optional and if nil it provides a default value
 - Looks a bit like the ternary operator
 */
/*:
 ###### _Example 1:_
 */

var age2: Int?
let unwrappedAge = age2 ?? 12

/*:
 ###### _Example 2:_
 */

var name: String?

//: Nil Coalescing Replaces 2 more verbose techniques
//: First Long way using basic ternary operator & nil checking
let result1 = name != nil ? name! : "Fat Freddy"
//: Nil coalescing (Sweet)
let result7 = name ?? "Slim Freddy"


//: Long way using optional binding
var result8 = ""
if let name = name {
  // name is unwrapped
  result8 = name
} else {
  // default value assigned if name is nil
  result8 = "Slow Freddy"
}
result8

/*:
 ###### _Example 2:_
 */
var age: Int? = 20

// ternary version
let result3 = age != nil ? age! : 30
//: - Notice nil coalescing does implicit nil checking (try removing != nil from the ternary operator).
//: - Nil coalsecing implicitly uses the unwrapped optional if not nil.
// nil coalescing version
let result4 = age ?? 40

/*: -------------------- */
/*:
 ##### _Do:_
 - rewrite the forced unwrap (below) using:
 - a) a basic nil check.
 - b) optional binding with if.
 - c) optional binding with guard.
 - d) nil coalescing.
 > Comment out the forced unwrap version line 84. Also, use fatalError() in the else condition of guard instead of return).
 */

var valueMustBeThere: Int? = 12
valueMustBeThere!

// a) nil check:


// b) optional binding using if:


// c) optional binding using guard:


// d) nil coalescing:


/*: -------------------- */
/*:
 #### _Implicit Unwrapping:_
 */

struct PhotoObject {
  let image:UIImage
}

class MyViewController: UIViewController {
  // property
  var photoObject:PhotoObject!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(#line, #function, "fired!")
    let imageView = UIImageView()
    imageView.image = photoObject.image
  }
}

let myVC = MyViewController()
myVC.photoObject = PhotoObject(image: UIImage())
// you have to call view to force viewDidLoad to fire
myVC.view.backgroundColor = UIColor.red

/*:
 #### _Questions:_
 * Why would you use an implicitly unwrapped optional in MyViewController?
 * What are the advantages/disadvantages of these 5 versions of unwrapping? Which should you prefer and why?
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
myCell.textLabel?.text = "My Dumb Label"
myCell

//: I'm upcasting here (Look ma no _as_).
// Notice I don't need to:
// vanillaCell = myCell as UITableViewCell
// This is because the compiler knows that the type of MyCell is a subclass of UITableViewCell so it is-a UITableViewCell.

vanillaCell = myCell
print(#line, (vanillaCell?.textLabel?.text)!) // this is optional chaining, more on this below.

/*: -------------------- */
class Mammal {}

class Person3: Mammal {
  var name: String?
}

class Dog: Mammal {}

//: Notice person is upcast to an AnyObject when I initialize it.

let person3: AnyObject = Person3()
if person3 is Mammal {
  print(#line, "Person is a mammal")
}

//: Because Person3 was cast to an AnyObject the compiler cannot infer its underlying type at compile time.
//: So if we try to _downcast_ person3 to it's underlying type Person3 we can't just use _as_ since this could fail.
//: So, we must indicate that this cast could fail using either the "?" called an "optional cast" or "!" which is an "forced downcast".
//: Just like forced unwrapping Swift will crash if you attempt to force downcast to an underlying type that isn't the case.
//: If you do an optional cast then you must still unwrap the result.

let optionalDownCastP3 = person3 as? Person3
let forcedDownCastP3 = person3 as! Mammal

/*:
 _Question:_
 * Should we use optional or forced downcast on our person3 instance?
 */

let p4 = person3 as? Dog // if we forced downcast this would crash

p4 //: p3 is _not_ of type Dog

/*: -------------------- */
/*:
 _Failable Initializer:_
 */

class Person4 {
  private let name:String
  init?(name:String) {
    guard name != "fred" else {
      return nil
    }
    self.name = name
  }
}

let p10 = Person4(name: "fred")


/*: -------------------- */
/*:
 #### **Optional Chaining**
 - Is Shorthand for unwrapping optionals.
 - It overloads the `?`, which makes it a bit confusing.
 - The whole expression evalutes to an optional. So, you still have to unwrap the whole expression.
 - It allows a nested optional expression to fail anywhere along the unwrapping.
 - If it does fail to have a value anywhere along the expression the whole expression evaluates to an optional containing nil.
 */

/*: -------------------- */
/*:
 #### **Optional Chaining First Example**
 */
class Borked {
  private var b:String?
  internal var inner:InnerBorked?
  init?(b:String?) {
    guard b != nil else {
      return nil
    }
    self.b = b
    self.inner = InnerBorked(c: self.b)
  }
  class InnerBorked {
    var c: String?
    init?(c:String?) {
      guard c != nil else {
        return nil
      }
      self.c = c
    }
  }
}

let borked = Borked(b: "something")
let inner = borked?.inner?.c
if let inner = inner {
  print(#line, inner)
}

/*: -------------------- */
/*:
 #### **Optional Chaining Second Example**
 */
class LibraryCard2 {
  let number: Int?
  // library cards have no number if they are expired
  init(number:Int?) {
    self.number = number
  }
}

class Citizen {
  // not every citize has a libraryCard
  var libraryCard: LibraryCard2?
  init?() {}
}



let citizen = Citizen()
let libraryCardNot = citizen?.libraryCard?.number

libraryCardNot // nil

// Creating another one
let libraryCard = LibraryCard2(number: 12)

let citizen2 = Citizen()
citizen2?.libraryCard = libraryCard
let number = citizen2?.libraryCard?.number // NOTICE number is still an OPTIONAL with optional chaining even though citizen2, libraryCard and number all have values
let unwrappedNumber = number!

//: Why do we need optional chaining!?
//: citizen2.libraryCard?.number replaces the following mess!

var result9: Int?

if citizen2 != nil {
  if citizen2!.libraryCard != nil {
    if citizen2!.libraryCard?.number != nil {
      result9 = citizen2!.libraryCard!.number
    }
  } else {
    result9 = nil
  }
} else {
  result9 = nil
}

print(result9 ?? "nil ist here")

// same thing with guard

guard let citizen2 = citizen2, let libraryCard = citizen2.libraryCard  else {
  fatalError()
}

citizen2.libraryCard?.number

// here it is using optional binding.

//if let citizen2 = citizen2 {
//    if let libraryCard = citizen2.libraryCard {
//    print(libraryCard.number)
//    }
//}
//
//// I can also drop the nesting and do it inline
//if let citizen2 = citizen2, libraryCard = citizen2.libraryCard {
//    print(libraryCard.number)
//}


/*:
 ##### _Do On Your Own:_
 - vanillaCell?.textLabel?.text above is optional chaining.
 - Write this statement out long hand using != nil for each element and print the unwrapped text value. Do it using guard let and if let as well.
 */


