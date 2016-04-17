//: [Previous](@previous)

import Foundation

/*:
 ##### Property Observers
 - Allow you to intercept calls just before a property is set and just after
 - `willSet` `didSet`
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
//    sleep(2)
    print(oldValue.last?.text)
}
willSet {
//    sleep(2)
    print(newValue.last?.text)
}
}



let todo = ToDo(text: "Pick up lettuce", priority: ToDo.Priority.High)
todoItem.append(todo)

/*:
 ##### _Do:_
 - Create a class called LibraryCard
 - Create a custom init that takes a random Int value and sets the LibraryCard instance's property _number_
 - Add a property observer to the _number_ property and intercept willSet
 - print the value before it is assigned
 - Create an empty array that holds LibraryCards
 - Write a for in loop that creates 20 cards and adds them to the array
 */

//: [Next](@next)
