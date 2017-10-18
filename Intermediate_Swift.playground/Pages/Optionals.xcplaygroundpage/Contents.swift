//: [Previous](@previous)

import UIKit
import PlaygroundSupport

// PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 ## **More Optionals**
 - - - - -
 * What are optionals?
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
 - Eg. a Person has a LibraryCard.
 - Since not every person has a library card we should model this as an optional.
 - Optionals have 2 possibilities: 1) there is a value and you can unwrap it to access the value, or 2) there isn't a value, it is `nil`, and unwrapping crashes the app.
 - In Swift you can only assign `nil` to a value that is marked as being an optional type.
 - So, if I plan on setting a variable to `nil` at any point in its life then it must be wrapped as an optional.
 - One place this comes up often is in VC's when you have a property that doesn't have a value at initialization time (outlets for instance).
 */

var opt1: String? = "hello"
opt1 = nil

// eg.
class MyVC: UIViewController {
  var name: String?
}

let myVC = MyVC()
myVC.name

/*:
 ##### **Question:**
 * What are some of the differences between Swift's nil and Objc's nil?
 */

/*:
 ##### **Basic Example:**
 */

var numString = "45l"

let result6 = Int(numString) // Int() Attempts to Convert a String to Int but it could fail

print(#line, result6 as Any)

/*:
 - Notice we can't do addition with `result6`. Why?
 */

// let newResult6 = result6 + 10 // this throws an error

/*:
 ##### **Creating our own optional**
 */

enum MyOptional<T> {
  case none
  case some(T)
}

let myO1 = MyOptional<String>.none

let myO2 = MyOptional<String>.some("Hello optional!")

switch myO1 {
case .none:
  print(#line, "my nil")
case .some(let message):
  print(#line, "\(message)")
}

switch myO2 {
case .none:
  print(#line, "my nil")
case .some(let message):
  print(#line, "\(message)")
}

/*:
 * 🤓 The idea of optionals is borrowed from Haskell.
 */

/*:
 ##### Unwrapping
 - Think of optionals as boxed objects (remember how you have to unwrap NSNumber to do math with it. You must unbox optionals to do stuff with them just the same).
 - If you force unwrap an optional that is `nil` Swift will crash.
 - There are numerous ways to unwrap optionals in Swift and how you do this is important to readability and good coding style.
 - You want to avoid awkward and unnecessary unwrapping code. This can interfere with code readability.
 */

/*:
 ** Unwrapping Techniques
 - Forced unwrapping.
 - `nil` checking with forced unwrapping.
 - Optional binding (with `if` and `guard`).
 - `nil` Coalescing.
 - Implicit unwrapping.
 - Optional Chaining.
 */

/*: -------------------- */
/*:
 ##### **Forced UnWrap**
 - Everyone knows about forced unwrap.
 - Use it when you **absolutely** expect a value to be there and the app cannot continue without the value.
 - Has the advantage of simplicity and readability.
 - But it's the most dangerous.
 - Avoid using forced unwrap just because you don't understand what's happening.
 - Never force unwrap a value you didn't create, like data from a network request. Why?
 */

//Eg. Forced Unwrap
let nummy = Int("12")
print(#line, nummy as Any) // notice this prints the int wrapped as an optional
nummy! // Is this reasonable here or should I protect against this being nil?

/*: -------------------- */
/*:
 ##### **`nil` checking with forced unwrap**
 - Simple and pretty readable.
 - Sometimes useful.
 - But it requires the extra step of force unwrapping. Why is this a problem?
 */

var dict1 = ["key1": 12]

// Note: Attempts to access a dictionary always return an optional
let val1 = dict1["key1"]

// prefer optional binding for examples of this kind.

if val1 != nil {
  let result = val1! + 10 // we must unwrap it to do stuff
  print(#line, result)
}

/*:
 ##### **Optional Binding (prefer this 😀 to nil checking and forced unwrap) **
 - `if let/var`
 - `guard let/var`
 - Use them when a `nil` value is possible and prefer them over forced unwrapping and nil checking.
 - Use `guard let` if you want an _early exit_ in the `nil`.
 - You can't "fall through" with guard on the `nil` case.
 - So sometimes you have to use if let/var instead if you need to "fall through" and continue to do stuff even if some value is `nil`.
 */


let ss = Int("10")

guard let sss = ss else {
  fatalError()
}

print(#line, sss + 10) // we have access to sss unwrapped outside the check.

if let ss = ss {
  print(#line, ss + 20)
}


/*:
 ###### **Questions:**
 * What's the difference between `guard let/var` and `if let/var`?
 * Which one should you prefer and why?
 */


/*:
 ######_Example 2_
 */

class LibraryCard {
  let number:Int
  init(num:Int) {
    self.number = num
  }
}

class Person {
  var libraryCard:LibraryCard?
  init(libraryCard:LibraryCard? = nil) {
    self.libraryCard = libraryCard
  }
}

var noCardPerson = Person()

if let libCard = noCardPerson.libraryCard {
  print(#line, "has a library card!")
} else {
  print(#line, "has no library card.") // this prints
}

let cardPerson = Person(libraryCard: LibraryCard(num: 1234))

if let libCard = cardPerson.libraryCard {
  print(#line, "person with card number ", libCard.number)
}

// chaining conditional binding expressions
let newName = "fred"

if let libCard = noCardPerson.libraryCard, let myFavNum = Int("42"), newName == "fred", libCard.number == 1234 {
  print(#line, "Why won't this print?")
}

// chaining with guard

guard let num1 = Int("44"), var num2 = Int("99"), num1 == 44, num2 == 99 else {
  fatalError()
}

num1
num2 += 1 // num2 is unwrapped

//: 📝 If any of the expressions in the guard chain fail the whole thing does and the else condition runs. We can do the same this with if.

if let num1 = Int("44"), var num2 = Int("99"), num1 == 44, num2 == 99 {
  print(#line, "all this is true")
}

/*: -------------------- */
/*:
 ##### _Defer:_
 * Provides a single way to execute some code whenever the function leaves the scope, no matter how it leaves the scope.
 * You can't return anything from `defer`.
 * Be careful with async and `defer` because the function might exit but be waiting for a callback.
 * A good real world example of this is executing a closure in a network completion handler that passes nil in if the request fails for some reason, otherwise it passes in the data.
 */

enum NetworkError: Error, LocalizedError {
  case bumURL
  var errorDescription: String? {
    switch self {
    case .bumURL:
      return NSLocalizedString("url is wrong", comment: "")
    }
  }
}

func fakeNetworkRequest(with url: URL, completion: (String?, Error?)-> Void ) {
  
  var result: String?
  var error: Error?
  
  defer {
    print(#line, "defer called")
    completion(result, error)
  }
  
  if url.absoluteString == "https://google.com" {
    error = NetworkError.bumURL
    return
  }
  
  result = "Something went right!"
}

fakeNetworkRequest(with: URL(string: "https://google.com")!) { (str: String?, err: Error?) in
  
  if let err = err {
    print(#line, err.localizedDescription)
    return
  }
  
  guard let str = str else {
    return
  }
  print(#line, str)
}

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

var age2: Int?
let unwrappedAge = age2 ?? 12 // 12

/*:
 ###### _Example 2:_
 */

var name: String?

//: Nil Coalescing is a convenience that replaces longer structures

var result1b: String = ""

if let name = name {
  result1b = name
} else {
  result1b = "Fat Freddy"
}

result1b

//: Or using the ternary operator
let result1 = name != nil ? name! : "Fat Freddy"

//: Here it is using `nil coalescing` (🍭)
//: Notice how `nil coalescing` does an implicit nil check and returns the unwrapped value if it's not nil.

let result7 = name ?? "Slim Freddy"

/*: -------------------- */

/*:
 ##### _Do:_
 - . Attempt to unwrap this expression `var age: Int? = 20` using:
 - a) basic `nil` check
 - b) optional binding using `if`
 - c) optional binding using `guard`
 - c) `nil coalscing` and assign 10 as the default
 */

var age: Int? = 20
// a) `nil` check:



// b) optional binding using `if`:


// c) optional binding using `guard`:


// d) `nil coalescing` with 10 as default:


/*: -------------------- */
/*:
 #### _Implicit Unwrapping:_
 * Omits the need to have to unnecessarily deal with unwrapping optionals everywhere.
 * Used especially for properties that might be nil at initialization, but have a value by the time they are used (eg. outlets).
 */

class Dummy {
  var implicitlyUnwrappedImage: UIImage!
}

let d = Dummy()
d.implicitlyUnwrappedImage = UIImage(named: "swift.png")
d.implicitlyUnwrappedImage
d.implicitlyUnwrappedImage = nil

/*: -------------------- */
/*:
 ##### **Optionals & Casting**
 * Notice: Upcasting is _implicit_!
 */

//: Example of `implicit upcasting`

var vanillaCell: UITableViewCell = UITableViewCell()

class MyCell: UITableViewCell {}

let myCell: MyCell = MyCell()

vanillaCell = myCell

//: I'm upcasting from MyCell to UITableViewCell it's super class.
//: I can declare this case explicitly, but never do this.
//: The upcast cannot fail and the super class of MyCell is known at compile time.

//vanillaCell = myCell as UITableViewCell

//: So, upcasting is free/implicit and can't fail.
//: Optionals aren't relevant to upcasting for this reason.

/*: -------------------- */
/*:
 #### _DownCasting:_
 */

class Mammal {}

class Person3: Mammal {
  var name: String?
}

class Dog: Mammal {}

//: Notice person is upcast to an AnyObject when I initialize it.
let person3: AnyObject = Person3()

//: We know Person is a Mammal though.
if person3 is Mammal {
  print(#line, "Person is a mammal")
}

/*:
 * Because Person3 was upcast to an AnyObject the compiler cannot infer its underlying type until it is used at runtime.
 * If we try to _downcast_ person3 to it's underlying type `Person3` we can't just use _as_ since this cast _could fail_ if we made a mistake.
 * We must indicate that this cast could fail using either the "?" called an "optional downcast" or "!" which is an "forced downcast".
 * Like forced unwrapping Swift will crash if you attempt to force downcast to the wrong type.
 * If you do an optional cast then you must still unwrap the result.
 * Never assume that your downcast will work unless you wrote the code. Handle failed downcasts gracefully.
 */


// ❓Why does this not print?

if let optionalDownCastP3 = person3 as? Person3, let name = optionalDownCastP3.name {
  print(#line, name)
}

let forcedDownCastP3 = person3 as! Mammal
// Why can't I access `name` on forcedDownCastP3


/*:
 _Question:_
 * Should we use optional or forced downcast on our person3 instance?
 */

let p4 = person3 as? Dog // Optional Dog
p4 // nil because persons are not Dogs!

// if we forced downcast this would crash
// let p44 = person3 as! Dog


/*: -------------------- */
/*:
 ##### **Failable Initializer**
 * A possible use for this might be a model object that could handle parsing a small chunk of JSON and fail to initialize if the JSON is malformed.
 * Many framework initializers are failable in iOS.
 */

class Person4 {
  private(set) var name: String
  init?(json: Dictionary<String,Any>) {
    guard let name = json["name"] as? String else {
      return nil
    }
    self.name = name
  }
}

let p10 = Person4(json: ["name":"fred"]) // works
let p1111 = Person4(json: ["name": true]) // nil
let p111 = Person4(json: ["age": 12]) // nil

/*: -------------------- */
/*:
 #### **Optional Chaining**
 - Is a shorthand for unwrapping optionals.
 - It overloads the `?`, which makes it a bit confusing. `?` is ordinarily used to wrap a value!
 - The whole expression evalutes to an optional. So, you still have to unwrap the whole expression.
 - It allows a nested optional expression to fail anywhere along the unwrapping.
 - If it does fail to have a value anywhere along the expression the whole expression evaluates to an optional containing nil.
 - If each optional has a value then the whole expression evaluates to an optional containing a value.
 */

/*: -------------------- */
/*:
 #### **Optional Chaining**
 */

class LibraryCard2 {
  var borrowCount: Int = 0
}

class Citizen {
  // not every citize has a libraryCard
  private(set) internal var libraryCard: LibraryCard2?
  init(libraryCard: LibraryCard2? = nil) {
    self.libraryCard = libraryCard
  }
}



let citizen = Citizen() // no lib card

/*:
 * We wanted to access the `borrowCount` of the LibraryCard.
 * `borrowCount` is not an optional.
 * `libraryCard` on citizen is optional though.
 * So, we could test to see if citizen has a libraryCard and then access the count.
 */

if let libCard = citizen.libraryCard {
  print(#line, libCard.borrowCount)
}

//: Or we could use _Optional Chaining_ (preferred) like this:

let noCount = citizen.libraryCard?.borrowCount // borrowCount has become an optional because libraryCard is!

noCount // nil since citizen has no library card

//: It's better to try to optionally bind the result of the optional chaining expression like this:

if let theCount = citizen.libraryCard?.borrowCount {
  print(#line, theCount)
} else {
  print(#line, "theCount is nil")
}


//: 📝 The `?` when added after a *type* means: "this is an optional and the value could be absent/nil at some point, so wrap it in an optional".
//: Eg.

var myOpttt: String?
myOpttt = "assigned"
myOpttt = nil

//: 📝 The `?` when added after the cast declaration `as?` means: "this cast might fail and hence evaluate to nil, so wrap it in an optional".

let baddd: AnyObject = MyCell()
let badddCast = baddd as? UITableView
badddCast

//: 📝 The `?` when added after an init means: "the returned object could be nil so wrap the return in an optional".

class BummerObject {
  init?(){
    return nil
  }
}

let myObj = BummerObject()

/*:
 * 📝 But the `?` when added after a property means something completely different.
 * When added after an optional property `?` means: "if it has a value access it, otherwise evaluate to nil and exit".
 * Optional chaining can work on any number of optional properties (a chain).
 * Optional chaining can fail anywhere along the chain if it encounters a nil.
 * _Whether the chain has a value or doesn't, the expression is "unwound" and the final result is wrapped in an optional_.
 * Think of it like "bubbling" any value up to the top level optional.
 * You still need to unwrap the top level optional.
 */

// Creating another one
let libraryCard = LibraryCard2()
libraryCard.borrowCount = 10

let citizen2 = Citizen(libraryCard: libraryCard)
let number = citizen2.libraryCard?.borrowCount // borrowCount has become an optional even though libraryCard exists, and borrowCount is NOT an optional because it _could_ have been otherwise.

// We still have to unwrap it to do stuff with it (notice I'm binding to a var here to allow me to mutate it)

if var number = number {
  number += 1
}

// Example from UIKit

var cell: MyCell? = MyCell()
var text = cell?.textLabel?.text // text is also an optional

text = "something special" // notice we don't need to unwrap it to assign
text

cell = nil
cell?.textLabel?.text = "never assigned because the cell is now nil"


/*: -------------------- */
/*:
 ##### **Why Optional Chaining?**
 */

var result: String? = nil

if let cell = cell {
  if let textLabel = cell.textLabel {
    if let text3 = textLabel.text {
      result = text3
    }
  }
}

//: ☠️ Pyramid of DOOM!


/*:
 * Attempting to assign a value to an optional chain returns `Void?`.
 * This allows us to check to see if the assignment was successful.
 */


if (cell?.textLabel?.text = "Yo") != nil {
  print(#line, "The assignment succeeded")
} else {
  print(#line, "assignment ☠️")
}


citizen.libraryCard?.borrowCount // this is nil, so the assignment returns nil not Void

if (citizen.libraryCard?.borrowCount = 10) == nil {
  print(#line, "assignment failed")
}

if let assignment = UITableViewCell().textLabel?.text = "some assignment" {
  print(#line, "the assignment succeeded \(assignment)")
}



