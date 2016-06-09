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
 - `let rightMovement = Movement(rawValue: "right")`
 */

//: Basic example:
enum LoginErrorMessages:String {
    case NoPassword = "Password is required!"
    case NoUserName = "User name is required!"
    case IncorrectLogin = "Your user name and password are incorrect."
}

let message = LoginErrorMessages.IncorrectLogin

print(message.rawValue)

switch message {
case .NoPassword:
    print(message.rawValue)
case .NoUserName:
    print(message.rawValue)
case .IncorrectLogin:
    print(message.rawValue)
}

//: Enums as String values
class MyCoolController:UIViewController {
    
    enum SegueIdentifier:String {
        case MasterViewController
        case DetailViewController
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
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
    print("score is \(score)")
default:
    print("cases must be exaustive")
}

//: Init and Enums

enum Direction:String {
    case North, South, East, West
    init() {
        self = .North
    }
}

let direction = Direction()
print(direction) // NOTICE: I don't need to call "rawValue" to get the string

//: Auto Increment

enum WorkDay:Int {
    case M=1,T,W,R,F
}

let workDay = WorkDay.T
workDay.rawValue + 10

switch workDay {
case .M,.T:
    print("Early Week")
case .W,.R:
    print("Mid Week")
case .F:
    print("End of Week")
}

enum Progress {
    case Unstarted
    case PercentComplete(percent: Int)
    case Complete
}

let percentComplete = Progress.PercentComplete(percent:76)

switch percentComplete {
case .PercentComplete (let thePercent) where 1...50 ~= thePercent:
    print("keep going")
case .PercentComplete (let thePercent) where 51...75 ~= thePercent:
    print("Almost there")
case .PercentComplete (let thePercent) where 76...99 ~= thePercent:
    print("Good as done")
case .Complete:
    print("I'm done!")
case Progress.Unstarted:
    print("Everyone has to start somewhere")
default:
    print("required in this case")
}



struct BlackjackCard {
    
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
card.description
card.suit.rawValue
card.rank.values.first


//: [Next](@next)
