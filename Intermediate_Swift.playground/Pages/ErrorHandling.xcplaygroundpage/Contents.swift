//: [Previous](@previous)

import Foundation


enum NamingError:Error {
  case anyoneButTrump(String)
  case notTaylorSwift(String)
}

func fullName(from firstName:String, and lastName:String)throws -> String {
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
