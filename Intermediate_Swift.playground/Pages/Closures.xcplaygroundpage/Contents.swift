//: [Previous](@previous)

import Foundation

/*:
 ### **Named Closures (AKA Functions)**
 - "Closures are self-contained blocks of functionality that can be passed around and used in your code"
 - By this definition ordinary functions in Swift are closures!
 - Closures can also capture value from outside their scope (We'll come to this below)
 */
func myFunc() {
    print("Function passed to another function")
}

let functionConstant = myFunc // passing a func to a variable/constant

// func that takes a func paramater
func funkyFunc(f:()->()) {
    f()
}

funkyFunc(myFunc)
funkyFunc(functionConstant)

// Using typealias for readability

typealias simpleFunc = ()->()

func funkyFunc2(f:simpleFunc) {
    f()
}

funkyFunc2(myFunc)

/*:
 ##### Using Functions in CallBacks (cleaner than delegation!)
 - Plain functions can be passed to another object to be used as a callback or completion handler
 */
class MasterViewController {
    var detailViewController: DetailViewController?
    
    func completionHandler(data:String) {
        print("Master is printing data sent from detail: \(data)")
    }
    
    func eventFired() {
        detailViewController = DetailViewController()
        detailViewController!.completionHandler = completionHandler
    }
}

class DetailViewController {
    typealias callBack = (data:String)->(Void)
    var completionHandler:callBack!
    
    func buttonTapped() {
        // do some stuff
        sleep(2)
        // get some user input
        let userInputFromTextField = "Pick up milk"
        completionHandler(data:userInputFromTextField)
    }
}

let masterViewController = MasterViewController()
masterViewController.eventFired()
masterViewController.detailViewController?.buttonTapped()

/*:
 ##### _Do:_
 - Download starter project
 - Write a function on MasterViewController that takes a String parameter
 - Set the passed in String to the label
 - In the DetailViewController make a property for that function
 - In prepareForSegue assign the function property to the function
 - Call the function from the button tap on detailViewController
 */

/*:
 ##### **Unnamed Closures**
 - Closures are just like functions except they are unnamed
 */

// closure so simple you can't call it!

//{
//    print("the world's simplest closure")
//}

let close1 = { print("hello closure!") }

close1() // call it

// pass it to a function

func fn1(close:()->()) {
    close()
}

fn1(close1)

// closure with a paramater and no return value

let close2 = {
    (p: String) -> Void in
    print(p)
}

// calling & passing in data
close2("this closure takes a string argument")
/*:
 - Notice: closures move their parameters & return types inside the block
 
 `{ (parameters) -> returnType in statements }`
 */

// closure with 2 parameters and a return

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

// doing it with a function
func sorter1(item1: String, item2: String) -> Bool {
    return item1 < item2
}
foods.sort(sorter1)

// doing it with a closure

foods.sort({
    (item1: String, item2: String) -> Bool in
    return item1 < item2
})

/*:
 - Closure expressions that are passed inline to a function parameter can be greatly simplified because the compiler can infer its type
 - The `sort(_:)` function expects a closure that has 2 parameters of the same type that can be compared, and it returns a Bool
 - Based on this, the compiler can infer the closure type and we don't need to explicitly specify it like this
 */

foods.sort({ item1, item2 in return item1 < item2 })

/*:
 - Because this closure consists of a single expression, we can also omit the `return` keyword
 */

foods.sort({ item1, item2 in item1 < item2 })

/*:
 - Swift automatically generates shorthand argument names for inline closures: $0, $1, $2
 - So we can omit the list of arguments and also the `in` keyword
 */

foods.sort({ $0 < $1 })

/*:
 - Swift's String type actually defines the `>` and `<` as a function that takes 2 strings and returns a Bool depending on their order. So we can even omit the generated shorthand argumens!
 */

foods.sort(<)

/*:
 - If a closure is the last argument of a function you can move it out of the function's round parentheses
 - Here's the long version of `sort(_:)` again with using trailing closure syntax
 */

foods.sort(){
    (item1: String, item2: String) -> Bool in
    return item1 < item2
}

/*:
 - You can omit the round parentheses if it's the closure is the only argument
 */

foods.sort{
    (item1: String, item2: String) -> Bool in
    return item1 < item2
}

/*:
 ##### **Capturing Values**
 - Closures can capture constants/variables from their surrounding scope
 - Closures can use or even mutate these captured values even when they are passed to a function elsewhere
 - Swift allows nested functions and functions inside functions can use and mutate values from the surrounding scope
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
 - Instead of executing the inner function internally, let's return it.
 */

func outerFunc2()->(()->Int) {
    var num = 10
    func innerFunc()-> Int {
        num += 20
        return num
    }
    return innerFunc
}

let myInnerFunc = outerFunc2()
myInnerFunc()
myInnerFunc()

/*:
 - In this last example, since we are not calling the function internally it makes no sense to name it
 */

/*:
 ##### _Do:_
 - Rewrite the last function using a closure
 */

func outerFunc3()->(()->Int) {
    var num = 20
    return {
        num += 50
        return num
    }
}

let myInnerFunc2 = outerFunc3()
myInnerFunc2()
myInnerFunc2()








//: [Next](@next)
