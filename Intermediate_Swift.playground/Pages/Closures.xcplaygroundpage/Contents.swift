//: [Previous](@previous)

import UIKit

/*:
 ### **Named Closures (AKA Functions)**
 - "Closures are self-contained blocks of functionality that can be passed around and used in your code"
 - By this definition ordinary functions in Swift are closures!
 - Closures/Functions can also capture value from outside their scope (More on this below)
 - Closures/Functions are known as _first class citizens_. What does this mean?
 */

/*:
 ##### _Example of Function Passed as Parameter_
 */

func myFunc() {
    print(#line, "Function passed to another function executed")
}

let functionConstant = myFunc // assigning a function to a let/var (notice the "()" brackets are ommitted because we are not executing it)

func funkyFunc(f:(Void)-> Void) {
    print(#line, "\(#function) is executing")
    f()
}

// alernative syntax.
func funkyFunc1(f:()->()) {}
func funkyFunc11(f:(Void)->()){}
func funkyFunc111(f:()->(Void)){}

funkyFunc(myFunc)

funkyFunc(functionConstant)
/*:
 Using typealias for readability
 */
typealias SimpleFuncType = ()->()

func funkyFunc2(f:SimpleFuncType) {
    print(#line, "\(#function) is executing")
    f()
}

funkyFunc2(myFunc)

/*:
 ##### Using Functions in CallBacks
 - Plain functions (or closures) can be passed to another object to be used as a callback or completion handler
 - Apple uses this in all modern parts of the SDK as an alternative or adjunct to delegation!
 */
class MasterViewController:UIViewController {
    var detailViewController: DetailViewController! // why is this an implicitly unwrapped optional?
    
    func fakeEventFired() {
        detailViewController = DetailViewController()
        detailViewController.completionHandler = completionHandler
    }
}

// optionally put the function in an extension
extension MasterViewController {
    func completionHandler(data:String)->Void {
        print(#line, "Master is printing data sent from detail: \(data)")
    }
}

class DetailViewController: UIViewController {
    
    typealias CallBack = (data:String)->(Void)
    
    var completionHandler:CallBack! // why is this implicitly unwrapped?
    
    func fakeButtonTap() {
        // do some long running task
        sleep(2)
        // get some user input
        let fakeUserData = "Pick up milk"
        // call the function assigned to the completionHandler variable with data
        completionHandler(data:fakeUserData)
    }
}

//let masterViewController = MasterViewController()
//masterViewController.fakeEventFired()
//masterViewController.detailViewController?.fakeButtonTap()

/*:
 ##### **Unnamed Functions AKA CLOSURES**
 Closures are just like functions except they are *unnamed*!
 */
/*: World's simplest Swift closure! Takes no paramaters and returns nothing. */

_ = {
    print(#line, "the world's simplest closure")
}()


// Assigning a simple closure to a constant
let close1 = { print(#line, "hello closure!") }

/*
 Compared to objc
 void (^closeObjc)(void) = ^{ NSLog(@"hello objc!"; }
 */

close1() // call it using the assigned constant

// closeObjc()
/*:
 passing a closure to a function
 */
func f1(close:()->()) {
    close()
}

f1(close1)

/*:
 calling the same closure but passing a closure as a literal!
 */

f1({
    print(#line, "In line closure executed")
})

/*:
 closure with a String parameter and no return value
 */
let close2 = {
    (string: String) -> Void in
    print(#line, string)
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

print(#line, r11)

//let result = multiply(12, 10)

/*:
 ##### _Do:_
 - Add a few simple closures to an array
 - These closures should probably take no inputs but just print out a message (it's up to you)
 - Write a forin loop and invoke each closure
 */

/*:
 #### Why Closures?
 - If functions just are named closures, then why do we need closures at all?
 - Closures are simply a convenience.
 - Sometimes, especially when we want to pass a function as an argument, we don't want to create a function separately and pass the name of the function. It's much more readable and convenient to pass everything inline.
 - Let's look at Swift's sort(_:) function that expects a function/closure like this.
 */

let foods = ["zuccini", "banana", "avacado", "lettuce", "walnut", "tahini", "bread"]
/*:
 Doing it with a function:
 */
func sorter1(item1: String, item2: String) -> Bool {
    return item1 < item2
}

let r22 = foods.sort(sorter1)
print(#line, r22)

/*:
 Doing it with a closure:
 */

let r222 = foods.sort({
    (item1: String, item2: String) -> Bool in
    return item1 < item2
})

print(#line, r222)

/*:
 - Closure expressions that are passed inline to a function parameter can be greatly simplified because the compiler can infer its type
 - The `sort(_:)` function expects a closure that has 2 parameters of the same type that can be compared, and it returns a Bool
 - Based on this, the compiler can infer the closure type.
 - So, we don't need to explicitly specify the parameter types and the return type.
 */

foods.sort({ item1, item2 in return item1 < item2 })

/*:
 Because this closure consists of a single expression, we can also omit the `return` keyword:
 */

foods.sort({ item1, item2 in item1 < item2 })

/*:
 Swift automatically generates shorthand argument names for inline closures: $0, $1, $2, etc.
 
 So we can omit the list of arguments and also the `in` keyword:
 */

foods.sort({ $0 < $1 })

/*:
 Swift's String type actually defines the `>` and `<` as a function that takes 2 strings and returns a Bool depending on their order. So we can even omit the generated shorthand arguments!
 */

foods.sort(>)

/*:
 ###### _Trailing Closure Syntax_
 If a closure is the last argument of a function you can move it out of the function's round parentheses
 
 Here's the long version of `sort(_:)` again using trailing closure syntax
 */

foods.sort(){
    (item1: String, item2: String) -> Bool in
    return item1 < item2
}

/*:
 You can also omit the round parentheses if the closure is the only argument:
 */

foods.sort{
    (item1: String, item2: String) -> Bool in
    return item1 < item2
}

/*:
 ##### _Do:_
 Rewrite the view controller callback using a closure rather than a function from around line 53
 */


/*:
 ##### **Capturing Values**
 - Closures can capture constants/variables from their surrounding scope
 - Closures can use and even mutate these captured values
 - Remember Swift allows nested functions
 - Nested functions can use and mutate values from the surrounding scope. Remember functions are just named closures.
 - Closures inside functions have the same behaviour as nested functions
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

outerFunc() // Explain the path of execution here and what happens

/*:
 Instead of executing the inner function internally, let's return it:
 */

func outerFunc2() -> ( () -> Int ) {
    var num = 10
    func innerFunc()-> Int {
        num += 20
        return num
    }
    return innerFunc
}

let myInnerFunc = outerFunc2() // returns the inner func
print(#line, myInnerFunc())
print(#line, myInnerFunc())

/*:
 Since we are not calling the function internally it makes no sense to name it!:
 */

/*:
 ##### _Do:_
 Rewrite the last function using a closure, call the new function outerFunc3() & invoke it and the closure:
 */


/*:
 ##### _Do:_
 Rewrite the last function using a closure, call it outerFunc4() and instead of hard coding the 20 pass in a value as a parameter to the closure
 */


/*:
 ###### _Capture List_:
 - Notice that nested functions & closures capture value by reference.
 - This means that the values capture can be mutated (as long as they are vars), which might not be what you want (Question: do Objc blocks capture by reference or value?)
 - In Swift you can use something called a _capture list_ to "turn off capture by reference"
 */

// Example illustrating capture by reference again.
// Make sure you totally understand what's going on here.

var z = 10
let close5 = { print(#line, "~~~>", z)}
z += 20
close5()

var y = 10
let close4 = {[y] in print(#line, "==>", y)}
y += 20

close4()

/*: Captureing self and retain cycles
 * In the lecture on debugging I demonstrated a retain cycle that resulted from capturing self in a closure
 * If an object owns a closure, and that closure owns self, then we have a retain cycle
 * This is why the compiler forces you to explicitly refer to self inside a closure
 * Sometimes you may want a closure to retain self, such as when you are waiting for a network callback and you don't want self to be deallocated before the callback
*/

class TempNotifier {
    var changeNotifier: ((Int) -> Void)?
    var currentTemp = 72
    init() {
        self.changeNotifier = {(temp: Int) in
            self.currentTemp = temp
        }
    }
}

/*:
 * Difference between `[unowned self]` and `[weak self]` is that if unowned self is nil the app will crash. weak self gives you the chance of handling the case where self is possibly nil.
 */

// Here's the example from the debugging lecture again
// Explain why this is a retain cycle?
// Do: Fix this using weak self in a capture list

class DetailVC:UIViewController {
    
    typealias Block = () -> Void
    var closure: Block!

    @IBAction func buttonTapped() {
        closure = {
            print("Some fake stuff")
            self.fakeFunk()
        }
        closure()
    }

    func fakeFunk() {
        print("fake funk")
    }
}


/*:
 ##### **Higher Order Functions**
 - Basically functions that take functions/closures and/or return them are called _Higher Order functions_. They are functions that act on other functions.
 - Swift has some important built in Higher Order functions, besides `sort()`
 - Let's look briefly at `map()`, `reduce()`, `filter()` (this is just an introduction)
 */

/*:
 ##### `map()`
 - Takes a closure as a parameter
 - It simply calls the expression on each element and returns the resulting array
 */

let arr1 = [Int](1...10)
let result2 = arr1.map({ (num:Int) -> String in
    return "\(num)"
})
print(#line, arr1)
print(#line, result2)

/*:
 Here's map in using terser syntax:
 */
let result22 = arr1.map{"\($0)"}
print(#line, result22)

/*:
 ##### `reduce()`
 Similar to the `map()` but it reduces all of the elements to a single value
 */

// long way
var result7 = 0
for item in arr1 {
    result7 += item
}
print(#line, result7)

// reduce way
let sum = arr1.reduce(0){ (num1: Int, num2: Int)-> Int in num1 + num2}
print(#line, sum)

//: Here's the same statement simplified:

let sum22 = arr1.reduce(0){ $0 + $1}
print(#line, sum22)

/*:
 ###### _`filter()`_
 Takes a closure and returns an array filtered according to whether it passes the test in the expression
 */

// forin long way
var result4: [Int] = []
for item in arr1 {
    if item % 3 == 0 {
        result4.append(item)
    }
}
print(#line, result4)

// filter way
let result8 = arr1.filter({
    (num1:Int) -> Bool in
    return num1 % 3 == 0
})
print(#line, result8)

//: Here's the same expression simplified:

let result9 = arr1.filter{$0 % 3 == 0}
print(#line, result9)


//: [Next](@next)
