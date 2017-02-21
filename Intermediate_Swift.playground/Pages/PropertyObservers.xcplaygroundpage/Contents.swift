//: [Previous](@previous)

import Foundation

/*:
 ##### Property Observers
 - Allow you to intercept calls just _before_ a property is set and just _after_ it was set
 - `willSet` and `didSet`
 - `willSet`: is called just before a property is set, which allows you to grab the old value
 - `didSet` is called just after a property is set
 - The most common use case is when you want to update your interface once a property has been set
 - `willSet` is most commonly used when you need to make use of an existing value before it gets set to a new value
 - How do you do this in Objc?
 - Properties in Swift are not functions like Objc. So if you see someone calling `func setFoo(foo:Foo){self.foo = foo}` in Swift they're most like doing something wrong.
 */

struct ToDo {
    enum Priority: String {
        case High, Medium, Low
    }
    let text: String
    var priority: Priority?
}

var todoArray:[ToDo] = [] {

    willSet {
        sleep(2)
        // newValue is the default name given to incoming value
        print("===>> willSet called", newValue.last?.text)
    }
    didSet {
        sleep(2)
        // oldValue is the default name given to old value
        print("===>> didSet called",  oldValue.last?.text)
    }
/*
 // DON'T DO THIS -Krusty
    willSet (newValueWithUnexpectedName) {
        sleep(2)
    print("===>> willSet called", newValueWithUnexpectedName.last?.text)
 }
 */

/*
// DON'T DO THIS -Krusty
    didSet (oldValueWithUnexpectedName){
        sleep(2)
        print("===>> didSet called", oldValueWithUnexpectedName.last?.text)
    }
 */
}

let todo1 = ToDo(text: "Pick up lettuce", priority: ToDo.Priority.High)

todoArray.append(todo1)

let todo2 = ToDo(text: "Get nuts", priority: ToDo.Priority.Low)

todoArray.append(todo2)

/*: 
 Question:
 - _willSet_ has a default param _newValue_
 - Why doesn't it also have a param _oldValue_ ?
 - _didSet_ has a default param _oldValue_
 - Why doesn't it also have a param _newValue_ ?
 */

class LibraryCard:CustomStringConvertible {
    var number = 11223 {
        willSet {
            print(#line, "willSet's oldValue == \(number) --- newValue == \(newValue)")
        }
        didSet {
            print(#line, "didSet's oldValue == \(oldValue) --- newValue \(number)")
        }
    }
    var description: String {
        return "card: \(number)"
    }
}

print(#line, Int(arc4random_uniform(3)))

var lib: [LibraryCard] = []

for i in 1...4 {
    let l = LibraryCard()
    l.number = Int(arc4random_uniform(1000+1)) // 1-1000 inclusive
    lib.append(l)
}

print(#line, lib)

/*:
 ##### Computed Properties
 - Computed properties do not store anything
 - They just compute a value, like a function that returns
 */

// must be a var
var firstName = "Harry"
var lastName = "Bonarry"

var fullName: String {
    return firstName + " " + lastName
}

print(#line, fullName)

// example using a class extension

class Person {
    private var firstName: String
    private var lastName: String
    init(firstName:String, lastName:String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension Person {
    // extensions cannot contain stored properties on the instance
    var fullName: String {
        return firstName + " " + lastName
    }
    
    static var storedStatic = "I'm a static stored on an extension so I'm not a stored instance property"
    
    // but I can put a struct/class inside the extension with a stored property. (Notice this is not stored on the instance)
    struct MyInnerStruct {
        var name: String
    }
    class MyInnerClass {
        var name: String = "default name"
    }
}

let person = Person(firstName: "Jane", lastName: "Doe")
print(#line, person.fullName)

let result = Person.MyInnerStruct(name:"Jane")
print(#line, result.name)

Person.MyInnerClass().name

Person.storedStatic
Person.storedStatic = "another value"
Person.storedStatic

/*:
 - Question: Why don't computed properties have property observers?
 */

//: [Next](@next)
