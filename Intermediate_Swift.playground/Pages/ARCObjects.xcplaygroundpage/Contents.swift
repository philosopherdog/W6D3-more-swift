//: [Previous](@previous)

import Foundation

/*:
![strong reference cycle](strong.png)
 */

class Person {
  let name: String
  init(name: String) {
    self.name = name
    print(#line, "👍🏼")
  }
  deinit {
    print(#line, "☠️")
  }
  var dog: Dog?
}

class Dog {  let name: String
  init(name: String) {
    self.name = name
    print(#line, "👍🏼")
  }
  var owner: Person?
  deinit {
    print(#line, "☠️")
  }
}

do {
  let person = Person(name: "steve")
  let dog = Dog(name: "snoppy")
  person.dog = dog
  dog.owner = person
}

/*:
 
 ## Weak vs Unowned
 - We could solve this with weak
 - Weak works with `var` and optional types
 - If every Dog instance had to have an owner then we would have to make the Dog unowned instead.

![breaking reference cycle](weak.png)
 
 */

//: [Next](@next)
