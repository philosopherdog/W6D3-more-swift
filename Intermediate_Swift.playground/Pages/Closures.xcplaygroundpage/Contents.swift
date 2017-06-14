//: [Previous](@previous)

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
 ### **Named Closures (AKA Functions)**
 - "Closures are self-contained blocks of functionality that can be passed around and used in your code"
 - By this definition ordinary functions in Swift are closures too!
 - Closures/Functions can also capture value from outside their scope (More on this below)
 - Closures/Functions are known as _first class citizens_. What does this mean?
 */

/*:
 ##### _Example of Function Passed as Parameter_
 */

func innerFunc() {
  print(#line, "Function passed to another function executed")
}

let function = innerFunc // assigning a function to a let/var (notice the "()" brackets are ommitted because we are not executing it.)

func function1(f:(Void)-> Void) {
  print(#line, #function, " is executing")
  f()
}

// Alernative syntax. We can omit the word Void if we wish.
func myFunctionAlt1(f:()->()) {}
func myFunctionAlt2(f:(Void)->()){}
func myFunctionAlt3(f:()->(Void)){}

// Calling myFunction with a function passed in. Notice no () because we're not executing it.

function1(f: function)

function1(f: innerFunc)

/*:
 Using typealias for readability
 */

typealias SimpleFuncType = ()->()

func function2(f: SimpleFuncType) {
  print(#line, #function, " is executing")
  f()
}

function2(f:function)

/*:
 ##### Function Internal/External Parameters
 */

// Suppressing the external parameter

func makeFullName(_ firstName: String, _ lastName: String)-> String {
  return firstName + " " + lastName
}

let firstName = "Fred"
let lastName = "FlintStone"

makeFullName(firstName, lastName)


/*:
 * Suppressing the first external parameter in Swift is used for Objc interoperability.
 
 - (void)doStuffWithStuff:(Stuff *)stuff andOtherStuff:(OtherStuff *)other;
 
 [obj doStuffWithStuff: stuff andOtherStuff: otherStuff];
 
 func doStuff(with stuff: Stuff, and otherStuff: OtherStuff)
 
 obj.doStuff(with: stuff, and: otherStuff)
 */

// Notice how splitting the name imposes a naming convention on the consumer!

func insertObject(at indexPath: NSIndexPath) {
  print(#line, indexPath)
}

let indexPath = NSIndexPath(row: 0, section: 2)
insertObject(at: indexPath)


/*:
 ##### **Unnamed Functions AKA CLOSURES**
 Closures are just like functions except they are *unnamed*!
 */
/*: World's simplest Swift closure! Takes no paramaters and returns nothing. */

_ = {
  print(#line, #function, " the world's simplest closure")
}()


// Assigning a simple closure to a constant
let close1:(Void)->(Void) = { print(#line, "hello closure!") }

/*
 Compared to objc
 void (^closeObjc)(void) = ^{ NSLog(@"hello objc!"; }
 */

close1() // call it using the assigned constant

// closeObjc()

/*:
 passing a closure to a function
 */

func f1(with close:()->()) {
  close()
}

// notice no ()
f1(with: close1)

/*:
 Calling the same closure but passing a closure as a literal!
 */

f1(with:{
  print(#line, "In line closure executed")
})

/*:
 Calling with trailing closure syntax (this is logically identical to the above call)
 */
f1{
  print(#line, "In line closure executed")
}

/*:
 closure with a String parameter and no return value
 */
let close2 = {
  // notice that the String type declaration can be inferred; so it is optional.
  (str) in
  print(#line, str)
}
/*:
 calling & passing in data:
 */
close2("How to call a closure with a string argument")

/*:
 Notice: closures move their parameters & return types inside the block
 `{ (parameters) -> returnType in statements }`
 */
/*:
 Closure with 2 parameters and a return. Here I'm calling it inline.
 */

let someNum = 10
let someOtherNum = 12

let r11 = {
  (num1: Int, num2: Int) -> Int in
  return num1 * num2
}(someNum, someOtherNum)

// r11 captures the result which is automatically called.

print(#line, r11)

let r134 = {
  (num1: Int, num2: Int) -> Int in
  return num1 * num2
}

// r134 captures
let result = r134(12, 10)


/*:
 ##### Using Functions in CallBacks
 - Plain functions (or closures) can be passed to another object to be used as a callback or completion handler.
 - Apple uses this in all modern parts of the SDK as an alternative or adjunct to delegation!
 - Can you pass a function to a method in Objc?
 */

class Photo {}

class MainVC: UIViewController {
  
  var photos = [Photo]() {
    didSet {
      // reload table
      print(#line, "object was added")
    }
  }
  
  // func is called by DVC
  func block(photo:Photo) {
    self.photos.append(photo)
  }
  
  let dvc = DVC()
  
  func prepare() {
    dvc.block = block(photo:)
  }
}

class DVC: UIViewController {
  
  var block:((Photo)->())!
  
  func save() {
    let photo = Photo()
    self.block(photo)
  }
}

let mainVC = MainVC()
mainVC.prepare()
mainVC.dvc.save()


/*:
 ##### _Do:_
 * Re-write the above and instead of creating a separate function create a closure.
 */

class MainVC2: UIViewController {
  
  var photos = [Photo]() {
    didSet {
      // reload table
      print(#line, "object was added")
    }
  }
  
  // func is called by DVC
  func block(photo:Photo) {
    self.photos.append(photo)
  }
  
  let dvc = DVC()
  
  func prepare() {
    dvc.block = block(photo:)
  }
}

class DVC2: UIViewController {
  
  var block:((Photo)->())!
  
  func save() {
    let photo = Photo()
    self.block(photo)
  }
}

/*:
 ##### _Do:_
 * Refactor the same method and pass the block straight into the save method instead of saving it as a property.
 */




// Adding Closures to an array

let aaa = [{ print("Hello") }, {print("world") }]
for a in aaa {
  a()
}

/*:
 #### Why Closures?
 - If functions just are named closures, then why do we need closures at all?
 - Closures are simply a convenience.
 - Sometimes, especially when we want to pass a function as an argument, we don't want to create a function separately and pass the name of the function. It's much more readable and convenient to pass everything inline if we don't.
 - Let's look at Swift's sort(_:) function that expects a function/closure and see the difference.
 */

let foods = ["zuccini", "banana", "avacado", "lettuce", "walnut", "tahini", "bread"]

/*:
 Doing it with a function:
 */

func sorter1(item1: String, item2: String) -> Bool {
  return item1 < item2
}

let r22 = foods.sorted(by: sorter1)
print(#line, r22)

/*:
 Doing it with a closure:
 */


let r222 = foods.sorted(by: { (item1:String, item2:String) -> Bool in
  return item1 < item2
})


print(#line, r222)

/*:
 * We can make this code more readable. Lets re-write the sort function above using trailing closure syntax.
 */

let r2222 = foods.sorted{ (item1, item2) in item1 < item2}

/*:
 - Closure expressions that are passed inline to a function parameter can be greatly simplified because the compiler can infer its type.
 - The `sorted(by:)` function expects a closure that has 2 parameters of the same type that can be compared, and it returns a Bool.
 - Based on this, the compiler can infer the closure type.
 - So, we don't need to specify the parameter types and the return type.
 */

var foods2 = ["zuccini", "banana", "avacado", "lettuce", "walnut", "tahini", "bread"]

// I'm using sort not sorted
// Also using trailing closure syntax

foods2.sort{ item1, item2 in return item1 < item2 }
foods2

/*:
 Because this closure consists of a single expression, we can also omit the `return` keyword:
 */

foods2.sort(by:{ item1, item2 in item1 > item2 })
foods2

/*:
 * Swift automatically generates shorthand argument names for inline closures: $0, $1, $2, etc.
 * So we can omit the list of arguments and also the `in` keyword:
 */

foods2.sort{$0 > $1}
foods2

/*:
 Swift's String type actually defines the `>` and `<` as a function that takes 2 strings and returns a Bool depending on their order. So we can even omit the generated shorthand arguments!
 */

foods2.sort(by:>)
foods2


/*:
 ###### _Trailing Closure Syntax_
 * If a closure is the last argument of a function you can move it out of the function's round parentheses, as we've seen.
 * Here's the long version of `sort(_:)` again using trailing closure syntax
 */

foods2.sort(){
  (item1: String, item2: String) -> Bool in
  return item1 > item2
}

/*:
 You can also omit the round parentheses if the closure is the only argument:
 */

foods2.sort{
  (item1: String, item2: String) -> Bool in
  return item1 < item2
}

/*:
 ##### **Capturing Values**
 - Closures can capture constants/variables from their surrounding scope. (So can functions).
 - Closures can use and even mutate these captured values.
 - Remember functions can be nested in Swift, as can classes, enums, and structs.
 - Nested functions can use and mutate values from the surrounding scope. Remember functions are just named closures.
 - Closures inside functions have the same behaviour as nested functions.
 */

func outerFunc() {
  var num = 10
  print(#line, "before", num)
  func innerFunc() {
    num += 20
  }
  innerFunc()
  print(#line, "after", num)
}

outerFunc() // Can someone walk us through this code?

/*:
 Instead of executing the inner function internally, let's return it so we can execute the returned function.
 */

func outerFunc2() -> ( () -> Int ) {
  var num = 10
  func innerFunc()-> Int {
    // num is captured
    num += 20
    return num
  }
  return innerFunc
}

let theInnerFunc = outerFunc2() // returns the inner func
print(#line, theInnerFunc())
print(#line, theInnerFunc())

/*:
 Since we are not calling the function internally it makes no sense to name it!:
 */

/*:
 ##### _Do:_
 Rewrite the last function using a closure & invoke it and the closure:
 */

func outerFunc3() -> ( () -> Int ) {
  var num = 10
  func innerFunc()-> Int {
    // num is captured
    num += 20
    return num
  }
  return innerFunc
}


/*:
 ##### _Do:_
 Rewrite the last function using a closure, call it outerFunc4() and instead of hard coding the 20, pass in a value as a parameter to the closure
 */

func outerFunc5() -> ( () -> Int ) {
  var num = 10
  func innerFunc()-> Int {
    // num is captured
    num += 20
    return num
  }
  return innerFunc
}



/*:
 ###### _Capture List_:
 - Notice that nested functions & closures capture value by reference.
 - This means that the values captured can be mutated (as long as they are vars), which might not be what you want (Question: do Objc blocks capture by reference or value?).
 - In Swift you can use something called a _capture list_ to "turn off" capture by reference.
 */

// Example illustrating capture by reference again.
// Make sure you totally understand what's going on here.

var z = 10
let close5 = {
  print(#line, "~~~>", z)
}
z += 20
close5()

var y = 10
let close4 = {
  [y] in
  print(#line, "==>", y)
}
y += 20

close4()

/*: Capturing self and retain cycles.
 * If an object owns a closure, and that closure owns self, then we have a retain cycle.
 * This is why the compiler forces you to explicitly refer to self inside a closure.
 * Sometimes you may want a closure to retain self, such as when you are waiting for a network callback and you don't want self to be deallocated before the callback.
 */

class TemperatureNotifier {
  
  var changeNotifier: ((Int) -> Void)?
  private var currentTemp = 72
  
  init() {
    self.changeNotifier = {[weak self](temp: Int) in
      guard let welf = self else {
        return
      }
      // if self were not weak it would increase the retain count of this instance by 1 because this closure captures self and self catures this closure.
      welf.currentTemp = temp
    }
  }
  
  func someEvent() {
    changeNotifier!(59)
    print(#line, currentTemp)
  }
}

let tempNotifier = TemperatureNotifier()
tempNotifier.someEvent()

/*:
 * Both `[unowned self]` and `[weak self]` do not increase the retain count.
 * But if unowned self is nil the app will crash. 
 * `weak self` gives you the chance of handling the case where self is possibly nil.
 */

/*:
 ##### **Higher Order Functions**
 - Basically functions that take functions/closures and/or return them are called _Higher Order functions_. We've already seen a bunch of custom examples of this.
 - Higher order functions are functions that act on other functions, that is they are functions that consume other functions.
 - Swift has some important built in Higher Order functions, besides `sort(by:)`.
 - Let's look briefly at `map()`, `reduce()`, `filter()` (this is just an introduction). These are considered "functional" elements in Swift and you will find similar constructs in modern languages and languages that aren't really OO like JS.
 */

/*:
 ##### `map()`
 - Takes a closure as a parameter.
 - It simply calls the expression on each element and returns the resulting array.
 - Same as a for loop but some consider it more expressive.
 */

let arr1 = [Int](1...10)
let result2 = arr1.map({ (num:Int) -> String in
  return "\(num)"
})

print(#line, arr1)
print(#line, result2)

/*:
 Here's map using terser syntax:
 */

let result22 = arr1.map{"\($0 + 10)"}
print(#line, result22)

// using a range
let result55 = (0...100).map{ $0 * 10 }
result55

// with stride
let sum33 = stride(from: 10, to: 100, by: 2).map{ $0 * 100}
sum33

/*:
 ##### `reduce()`
 Loops through all elements and "reduces" them to a single value.
 */

// long way
var result7 = 0
for item in arr1 {
  result7 += item
}
print(#line, result7)

// reduce way using named params:

let sum = arr1.reduce(0){ (num1: Int, num2: Int)-> Int in num1 + num2}
print(#line, sum)

//: Here's the same statement with default param names, starting at 10.

let sum22 = arr1.reduce(10){ $0 + $1}
print(#line, sum22)



/*:
 ###### _`filter()`_
 Takes a closure and returns an array filtered according to whether it passes the test in the expression.
 */

// forin long way
var result4: [Int] = []

// filter items equally divisible by 3.
for item in arr1 {
  if item % 3 == 0 {
    result4.append(item)
  }
}
print(#line, result4)

//: filter way without trailing closure syntax and using named params.

let result8 = arr1.filter({
  (num1:Int) -> Bool in
  return num1 % 3 == 0
})
print(#line, result8)

//: Here's the same expression simplified:

let result9 = arr1.filter{$0 % 3 == 0}
print(#line, result9)

//: These expressions are also chainable!

let crazyChain = (0...1000).filter{ $0 % 3 == 0 }.map{ $0 * 14 }.reduce(0){ $0 + $1 }

crazyChain




//: [Next](@next)
