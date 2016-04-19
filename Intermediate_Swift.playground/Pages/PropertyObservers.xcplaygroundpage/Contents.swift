//: [Previous](@previous)

import Foundation

/*:
 ##### Property Observers
 - Allow you to intercept calls just before a property is set and just after
 - `willSet` and `didSet`
 - `willSet` is called just before a property is set, which allows you to grab the old value
 - `didSet` is called just after a property is set
 - The most common use case is when you want to update your interface once a property has been set, or when it gets refreshed
 - `willSet` is most commonly used when you need to make use of the old value
 - How do you do this in objc?
 */

struct ToDo {
    enum Priority: String {
        case High, Medium, Low
    }
    let text: String
    var priority: Priority?
}

var todoItem:[ToDo] = [] {
didSet {
    // sleep(2)
    print("didSet called", oldValue.last?.text)
}
willSet {
    // sleep(2)
    print("willSet called", newValue.last?.text)
}
}



let todo1 = ToDo(text: "Pick up lettuce", priority: ToDo.Priority.High)
todoItem.append(todo1)
let todo2 = ToDo(text: "Pick up nuts", priority: ToDo.Priority.Low)
todoItem.append(todo2)

/*:
 ##### _Do:_
 - Create a class called LibraryCard
 - Create a custom init that takes an Int parameter called _number_
 - Assign a default value to _number_ property
 - When you create a LibraryCard generate a random number to pass to the _number_ param.
 - Add a property observer to the _number_ property and intercept _didSet_ and _willSet_
 - Print the old/default value in willSet and the new value in didSet
 - Create an empty array that holds LibraryCards
 - Write a forin loop that creates 20 cards and adds them to the array
 */
class LibraryCard {
    var number = 11223 {
        didSet {
            print("didSet newValue \(oldValue), the new value is \(number)")
        }
        willSet {
            print("willSet oldValue \(newValue) and the old value is \(number)")
        }
    }
}

var lib: [LibraryCard] = []

for i in 1...20 {
    let lib = LibraryCard()
    lib.number = Int(arc4random_uniform(1000+1))
}
//: [Next](@next)
