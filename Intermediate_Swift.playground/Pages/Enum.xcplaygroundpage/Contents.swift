//: [Previous](@previous)

import UIKit

/*:
 #### **Enum**
 - Swift has insanely powerful enums
 - declare types with finite sets of possible states & accompanying values
 - includes nesting, pattern matching, associated values
 - enum types are limited to Int, Float, String, Bool
 - access values using _.rawValue_
 - you can init an enum using it's associated raw value
 */

//: Basic example:
enum LoginErrorMessages:String {
    case NoPassword = "Password is required!"
    case NoUserName = "User name is required!"
    case IncorrectLogin = "Your user name and password are incorrect."
}

let message = LoginErrorMessages.IncorrectLogin

print(#line, message.rawValue)

switch message {
case .NoPassword:
    print(#line, message.rawValue)
case .NoUserName:
    print(#line, message.rawValue)
case .IncorrectLogin:
    print(#line, message.rawValue)
}

//: Enums as String values
class MyCoolController:UIViewController {
    
    enum SegueIdentifier:String {
        case MasterViewController
        case DetailViewController
    }
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier! == SegueIdentifier.MasterViewController.rawValue {
        }
    }
}

//: Passing in values to enums

enum MidtermScore {
    case Steve(score:Int)
    case George(score:Int)
}

let student = MidtermScore.Steve(score: 20)

switch student {
case .Steve (let score):
    print(#line, "score is \(score)")
default:
    print(#line, "cases must be exaustive")
}

//: Init and Enums

enum Direction:String {
    case North, South, East, West
    init() {
        self = .North
    }
}

let direction = Direction()
print(#line, direction)

//: Like Objc enums Int values auto increment

enum WorkDay:Int {
    case M=1,T,W,R,F
}

//: Initialize with a rawValue like this
let thurs = 4
//: Notice this rawValue initializer returns an optional as you would expect
let workDay2 = WorkDay(rawValue: thurs)
print(#line, workDay2!)

let workDay = WorkDay.T
print(#line, workDay.rawValue + 10)

switch workDay {
case .M,.T:
    print(#line, "Early Week")
case .W,.R:
    print(#line, "Mid Week")
case .F:
    print(#line, "End of Week")
}

enum Progress {
    case Unstarted
    case PercentComplete(percent: Int)
    case Complete
}

let percentComplete = Progress.PercentComplete(percent:76)

switch percentComplete {
case .PercentComplete (let thePercent) where 1...50 ~= thePercent:
    print(#line, "keep going")
case .PercentComplete (let thePercent) where 51...75 ~= thePercent:
    print(#line, "Almost there")
case .PercentComplete (let thePercent) where 76...99 ~= thePercent:
    print(#line, "Good as done")
case .Complete:
    print(#line, "I'm done!")
case Progress.Unstarted:
    print(#line, "Everyone has to start somewhere")
default:
    print(#line, "required in this case")
}



struct BlackjackCard:CustomStringConvertible {
    
    // nested Suit enumeration
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    // nested Rank enumeration
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int
            let second: Int?
        }
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let card = BlackjackCard(rank: .Ace, suit: .Clubs)
print(#line, card)
print(#line, card.suit.rawValue)
print(#line, card.rank.values.first)

let card2 = BlackjackCard(rank: .Eight, suit: .Diamonds)
print(#line, card2)
print(#line, card2.suit.rawValue)
print(#line, card2.rank.values.first)

//: [Next](@next)
