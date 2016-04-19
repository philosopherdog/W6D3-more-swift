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
class MyViewController:UIViewController {
    
    enum SegueIdentifier:String {
        case MasterViewController
        case DetailViewController
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender sender: AnyObject?) {
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
print(direction.rawValue)

//: Auto Increment

enum WorkDay:Int {
    case M=1,T,W,R,F
}

let workDay = WorkDay.T
print(workDay.rawValue)

switch workDay {
case .M,.T:
    print("Early Week")
case .W,.R:
    print("Mid Week")
case .F:
    print("End of Week")
}

/*: 
 ###### _Do:_
 - create an enum _Progress_
 - it has 3 cases: Unstarted, PercentComplete, and Complete
 - Percentcomplete takes a parameter labeled percent of type Int
 - make a PercentComplete and set its percent to different levels for testing
 - write a switch statement
 - the PercentComplete should have 3 separate cases for 1-50, 51-75, 76-99 
 - bind the percent to a constant and write a where clause for each case and print something according to the percent complete
 */

//: [Next](@next)
