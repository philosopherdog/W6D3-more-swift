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
### What are Optionals?
- Optionals are used in situations where a value may be absent.
- Eg. a Person class may have a LibraryCard property. Since some people don't have library cards we should model this as an optional.
- Optionals have 2 possibilities: 1) there is a value and you can unwrap it to access the value, or 2) there isn't a value, it is `nil`, and unwrapping crashes the app.
- In Swift you can only assign `nil` to a value that is marked as being an optional type.
- So, if I plan on setting a variable to `nil` at any point in its life then it must be wrapped as an optional type.
*/

var opt1: String? = "hello"
opt1 = nil

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
- Notice we can't do addition with `result6` because it is not an Int value but a boxed optional value.
*/

// let newResult6 = result6 + 10

/*:
 ##### Unwrapping
 - Think of optionals like boxed objects (just as you must unwrap NSNumber to do math with it, you must unbox optionals to do stuff with them).
 - If you force unwrap an optional that is `nil` Swift will of course crash.
 - There are numerous ways to unwrap optionals in Swift and how you do this is important to readability and if often a matter of coding style:
    - Forced unwrapping.
    - `nil` checking with forced unwrapping.
    - Optional binding.
    - `nil` Coalescing.
    - Implicit unwrapping.
    - Optional Chaining.
 */

/*: -------------------- */
/*:
 ##### **Forced UnWrap**
 - Everyone knows about forced unwrap.
 - Use it when you **absolutely** expect a value to be there and the app cannot continue without the value.
 - Can be helpful in development.
 - But deal with missing data more gracefully in a production apps.
 - Avoid using forced unwrap just because you don't understand what's happening.
 */

//Eg. Forced Unwrap
let nummy = Int("12")
print(#line, nummy as Any) // notice this prints the int wrapped
nummy!

/*: -------------------- */
/*:
 ##### **`nil` checking with forced unwrap**
 - Generally avoid doing this.
*/

var dict1 = ["key1": 12]

// Note: Attempts to access a dictionary always return an optional
let val1 = dict1["key1"]
if val1 != nil {
  let result = val1! + 10 // we must unwrap it to do stuff
  print(#line, result)
}

/*:
 ##### **Optional Binding**
 - `if let`
 - `guard let`
 - Use them when a `nil` value is possible and prefer them over forced unwrapping and nil checking.
 - Use `guard let` if you want an early exit if a given value(s) is `nil`.
 */

/*: -------------------- */
/*:
 ##### **Optional Binding With _if_**
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

// chaining conditional binding expressions (prefer this)
let newName = "fred"
if let libCard = p1.libraryCard, let myFavNum = Int("42"), newName == "fred", libCard.number == 1234 {
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

func catGreeting(with catName: String?) -> String {
  // nb. I'm making catName mutable, but remember it's a copy
  guard var catName = catName else {
    return "Cat name was nil!"
  }
  catName += " meow"
  return catName
}

var catName: String?

var greetingResult = catGreeting(with: catName)
print(#line, greetingResult)

catName = "Tashi"
greetingResult = catGreeting(with: catName)
print(#line, greetingResult)


// chaining

guard let num1 = Int("44"), var num2 = Int("99"), num1 == 44 else {
  fatalError()
}

num1
num2 += 1


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
// testDefer(exit: true)


/*: -------------------- */
/*:
 ##### **Nil Coalescing Operator:**
 - Unwraps an optional.
 - If the value is `nil` it provides a default value.
 - Looks a bit like the ternary operator.
 */
/*:
 ###### _Example 1:_
 */

var age2: Int? // optionals default to nil
let unwrappedAge = age2 ?? 12

/*:
 ###### _Example 2:_
 */

var name: String?

//: Nil Coalescing Replaces 2 more verbose techniques
//: First Long way using nil checking.
var result1b: String = ""

if name == nil {
  result1b = "Fat Freddy"
} else {
  result1b = name!
}

//: Here it using using the ternary operator
let result1 = name != nil ? name! : "Fat Freddy"

//: Here it is using `nil coalescing` (Sweet!)
//: Notice how `nil coalescing` does an implicit nil check.

let result7 = name ?? "Slim Freddy"

/*: -------------------- */

// let's assign something to name
name = "Foxleg"

/*:
 ##### _Do:_
 - 1. re-write `let result7 = name ?? "Slim Freddy"` using:
    - a) optional binding with both `if`
    - b) optional binding with both `guard`
 - 2. Attempt to unwrap this expression `var age: Int? = 20` using:
    - a) basic `nil` check
    - b) optional binding using `if`
    - c) optional binding using `guard`
    - c) `nil coalscing` and assign 10 as the default
  - 3. re-write `catGreeting(with:)` using the `nil coalescing` operator.
*/

// 1.
// a) if let:

// b) guard let:

// 2.
// a) `nil` check:


// b) optional binding using `if`:


// c) optional binding using `guard`:


// d) `nil coalescing` with 10 as default:


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
    view.addSubview(imageView)
    imageView.image = photoObject.image
  }
}

let myVC = MyViewController()
myVC.photoObject = PhotoObject(image: UIImage())
// you have to call view to force viewDidLoad to fire
myVC.view.backgroundColor = UIColor.red

/*: -------------------- */
/*:
 ##### **Optional Casting**
 Notice: Upcasting is _implicit_!
 */

//: Example of `implicit upcasting`

var vanillaCell: UITableViewCell?

class MyCell: UITableViewCell {}

let myCell = MyCell()
myCell.textLabel?.text = "pick up fruit"
myCell.textLabel?.text

//: I'm upcasting here (Look ma no _as_).
// Notice I don't need to:
// vanillaCell = myCell as UITableViewCell
// This is because the compiler knows that the type of MyCell is a subclass of UITableViewCell so it Is-A UITableViewCell. I explictly told it this by making MyCell a subclass of UITableViewCell.

vanillaCell = myCell
print(#line, (vanillaCell?.textLabel?.text)!) // this is optional chaining, more on this below. For now notice that each element in this chain is an optional.

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
//: So if we try to _downcast_ person3 to it's underlying type Person3 we can't just use _as_ since we could be mistaken and this could fail.
//: So, we must indicate that this cast could fail using either the "?" called an "optional downcast" or "!" which is an "forced downcast".
//: Just like forced unwrapping Swift will crash if you attempt to force downcast to an underlying type that turns out to be mistaken.
//: If you do an optional cast then you must still unwrap the result, but it prevents a crash if you make a mistake.

let optionalDownCastP3 = person3 as? Person3
let forcedDownCastP3 = person3 as! Mammal

/*:
 _Question:_
 * Should we use optional or forced downcast on our person3 instance?
 */

let p4 = person3 as? Dog // if we forced downcast this would crash

p4 //: p4 is _not_ of type Dog!

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
 - If each optional has a value then the whole expression evalutes to an optional containing a value.
 */

/*: -------------------- */
/*:
 #### **Optional Chaining First Example**
 */
class Borked {
  class InnerBorked {
    var c: String?
    init?(c:String?) {
      guard c != nil else {
        return nil
      }
      self.c = c
    }
  }
  private var b:String?
  internal var inner:InnerBorked?
  init?(b:String?) {
    guard b != nil else {
      return nil
    }
    self.b = b
    self.inner = InnerBorked(c: self.b)
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
  // library cards have no number if they are expired. It's POLICY man.
  init(number:Int?) {
    self.number = number
  }
}

extension LibraryCard2: Equatable {
  public static func ==(lhs: LibraryCard2, rhs: LibraryCard2) -> Bool {
    return lhs.number == rhs.number
  }
}

class Citizen {
  // not every citize has a libraryCard
  private let _blackListedCards:[LibraryCard2] = []
  internal var libraryCard: LibraryCard2?
  init?(libraryCard: LibraryCard2?) {
    if libraryCard != nil {
      let blackListCount = _blackListedCards.filter{ $0 == libraryCard }.count
      if blackListCount > 0 {
        return nil
      }
    }
    self.libraryCard = libraryCard
  }
}



let citizen = Citizen(libraryCard: nil)
let libraryCardNot = citizen?.libraryCard?.number

libraryCardNot // nil

// Creating another one
let libraryCard = LibraryCard2(number: 12)

let citizen2 = Citizen(libraryCard: libraryCard)
citizen2?.libraryCard = libraryCard
let number = citizen2?.libraryCard?.number // NOTICE number is still an OPTIONAL with optional chaining even though citizen2, libraryCard and number all have values
let unwrappedNumber = number ?? -1

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

result9 ?? -1h


