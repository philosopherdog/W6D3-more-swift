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
 ##### _Example of Function Parameter_
 */

func myFunc() {
    print("Function passed to another function")
}

let functionConstant = myFunc // assigning a function to a let/var (notice the "()" brackets are ommitted, so we are not calling it)
/*:
Example of a func that takes a func paramater
 */
func funkyFunc(f:()->()) {
    #function
    print("===>>> funkyFunc is executing")
    f()
}

funkyFunc(myFunc)

funkyFunc(functionConstant)
/*:
Using typealias for readability
*/
typealias SimpleFuncType = ()->()

func funkyFunc2(f:SimpleFuncType) {
    f()
}

funkyFunc2(myFunc)

/*:
 ##### Using Functions in CallBacks
 - Plain functions can be passed to another object to be used as a callback or completion handler
 - Apple uses this in all modern parts of the SDK
 */
class MasterViewController:UIViewController {
    var detailViewController: DetailViewController! // why is this an implicitly unwrapped optional?
    
    func fakeEventFired() {
        detailViewController = DetailViewController()
        detailViewController.completionHandler = completionHandler
    }
}

extension MasterViewController {
    func completionHandler(data:String) {
        print("Master is printing data sent from detail: \(data)")
    }
}

class DetailViewController: UIViewController {
    
    typealias CallBack = (data:String)->(Void)
    
    var completionHandler:CallBack!
    
    func fakeButtonTap() {
        // do some long running task
        sleep(2)
        // get some user input
        let fakeUserData = "Pick up milk"
        completionHandler(data:fakeUserData)
    }
}

let masterViewController = MasterViewController()
masterViewController.fakeEventFired()
masterViewController.detailViewController?.fakeButtonTap()

/*:
 ##### **Unnamed Functions AKA CLOSURES**
 Closures are just like functions except they are unnamed
 */
/*: A closure so simple you can't call it! */
//{
//    print("the world's simplest closure")
//}


// Here I assign a simple closure to a let
let close1 = { print("hello closure!") }
/*
 Compared to objc
 void (^closeObjc)(void) = ^{ NSLog(@"hello objc!"; }
 */

close1() // call it
// closeObjc()
/*:
passing a named closure to a function
*/
func f1(close:()->()) {
    close()
}

f1(close1)
/*:
closure with a String paramater and no return value
*/
let close2 = {
    (s: String) -> Void in
    print(s)
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
Closure with 2 parameters and a return:
*/
let multiply = {
    (num1: Int, num2: Int) -> Int in
    return num1 * num2
}

let result = multiply(12, 10)

/*:
 ##### _Do:_
 - Add a few simple closures to an array
 - These closures should probably take no inputs but just print out a message (it's up to you)
 - Write a forin loop and call each closure
 */


/*:
 #### Why Closures?
 - If functions just are named closures, then why do we need closures at all?
 - Closures are a convenience.
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

foods.sort(sorter1)
/*:
Doing it with a closure:
*/
foods.sort({
    (item1: String, item2: String) -> Bool in
    return item1 < item2
})

/*:
 - Closure expressions that are passed inline to a function parameter can be greatly simplified because the compiler can infer its type
 - The `sort(_:)` function expects a closure that has 2 parameters of the same type that can be compared, and it returns a Bool
 - Based on this, the compiler can infer the closure type and we don't need to explicitly specify it like this (We can omit the parameter types and the return type.
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
 ##### **Capturing Values**
 - Closures can capture constants/variables from their surrounding scope
 - Closures can use or even mutate these captured values even when they are passed to a function elsewhere
 - Swift allows nested functions
 - Nested functions can use and mutate values from the surrounding scope
 - Closures inside functions have the same behaviour
 */

func outerFunc() {
    var num = 10
    print("before", num)
    func innerFunc() {
        num += 20
    }
    innerFunc()
    print("after", num)
}

outerFunc()

/*:
 Instead of executing the inner function internally, let's return it:
 */

func outerFunc2()->(()->Int) {
    var num = 10
    func innerFunc()-> Int {
        num += 20
        return num
    }
    return innerFunc
}

let myInnerFunc = outerFunc2() // returns the inner func
myInnerFunc()
myInnerFunc()

/*:
 Since we are not calling the function internally it makes no sense to name it:
 */

/*:
 ##### _Do:_
 Rewrite the last function using a closure, call it outerFunc3():
 */

 

/*:
 ###### _Capture List_:
 - Notice that nested functions & closures capture value by reference.
 - This means that the values capture can be mutated, which might not be what you want (Question: do objc blocks capture by reference or value?)
 - Swift uses something called a _capture list_ to "turn off capture by reference"
 */

// example showing capture by reference again

var z = 10
let close5 = { print("~~~>", z)}
z += 20
close5()

var y = 10
let close4 = {[y] in print("==>", y)}
y = 12

close4() // prints 10


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
arr1
result2

/*: 
 ##### _Do:_
 Simplify the map statement above using the techniques we talked about earlier:
 */


/*:
 ##### `reduce()`
 Similar to the `map()` but it reduces all of the elements to a single value
 */
// long way
var result7 = 0
for item in arr1 {
    result7 += item
}
result7

// reduce way
let sum = arr1.reduce(0){ (num1: Int, num2: Int)-> Int in num1 + num2}
sum

/*:
 ##### _Do:_
 Simplify the reduce statement above as much as you can:
 */

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
result4

// filter way
let result8 = arr1.filter({(num: Int) -> Bool in
    return num % 3 == 0
})
result8

/*:
 ##### _Do:_
 Simplify the filter statement above as much as you can:
 */

/*:
 ##### _Do:_
 - Let's practice a bit
 - Below you will find an array that consists of a simple model object of type `Data`
 - Please follow the instructions for each section
*/

struct Data {
    let firstName: String
    let lastName: String
    let age: Int
}

let dataArray = [
    Data(firstName: "Ernie", lastName: "Slack", age: 62),
    Data(firstName: "Jim", lastName: "Jones", age: 33),
    Data(firstName: "Cray", lastName: "Lee", age: 44),
    Data(firstName: "Fats", lastName: "Way", age: 20)
]

dataArray

/*:
 ##### _Do:_
 - Using `map()` get an array of firstName lastName as a single string
 */


/*:
 ##### _Do:_
 - You can chain these expressions together.
 - Take the our first map expression and use the sort expression to sort the names in ascending order
 */


/*:
 ##### _Do:_
 - Using `reduce()` get the average age
 */


/*:
 ##### _Do:_
 - Using `filter()` get only those people whose name is "Jim"
 */




//: [Next](@next)
