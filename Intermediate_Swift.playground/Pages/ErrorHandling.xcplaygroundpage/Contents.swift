//: [Previous](@previous)

import Foundation

/*:
 ## Precondition/Assert
 - Assert is removed from release builds
 */

let value = 5
assert(value == 5)
precondition(value == 5)

/*:
 ## Optionals
 - Way of providing basic error handling
 - Eg. failable initializer
 - Good for simple errors.
*/

struct Person {
  let name: String
  init?(name: String) {
    if name == "Donald Drumpf" {
      return nil
    }
    self.name = name
  }
}

if let person = Person(name: "Donald Drumpf") {
  // never fires
  print(#line, person.name)
}

/*:
 ## Throwing
 - Either returns a value or an error.
 - Automatically converts to NSError and adds an NSError parameter to the Objc version.
 */

// Protocol Error, Associated values are not required
enum NamingError: Error {
  case anyoneButTrump(String)
  case notTaylorSwift(String)
}

func fullName(from firstName: String, and lastName: String) throws -> String {
  guard firstName != "Donald" && lastName != "Drumpf" else {
    throw NamingError.anyoneButTrump("Donald Trump NOT ALLOWED!")
  }
  guard firstName != "Taylor" && lastName != "Swift" else {
    throw NamingError.notTaylorSwift("Taylor Swift is lame")
  }
  return firstName + " " + lastName
}

var result:String?

do {
  result = try fullName(from: "Donald", and: "Drumpf")
}
catch NamingError.anyoneButTrump(let message) {
  print(#line, message)
}
catch NamingError.notTaylorSwift(let message) {
  print(#line, message)
}
catch let error as NSError {
  print(#line, error.localizedDescription, error.code, error.domain, error.userInfo)
}

result

do {
  result = try fullName(from: "Taylor", and: "Swift")
}
catch NamingError.anyoneButTrump(let message) {
  print(#line, message)
}
catch NamingError.notTaylorSwift(let message) {
  print(#line, message)
}

result

do {
  result = try fullName(from: "Iggy", and: "Pop")
}
catch NamingError.anyoneButTrump(let message) {
  print(#line, message)
}
catch NamingError.notTaylorSwift(let message) {
  print(#line, message)
}

result

let newResult = try? fullName(from: "Taylor", and: "Swift")
newResult






//: [Next](@next)
