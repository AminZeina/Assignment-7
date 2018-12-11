// Created on: Dec 2018
// Created by: Amin Zeina
// Created for: ICS3U
// This program calculates the average of levels

// this will be commented out when code moved to Xcode
import PlaygroundSupport


import UIKit

class ViewController : UIViewController {
    // this is the main view controller, that will show the UIKit elements
    
    // properties
    let instructionLabel = UILabel()
    let answerLabel = UILabel()
    let gradeLevelTextField = UITextField()
    let enterButton = UIButton()
    let removeLastButton = UIButton()
    let getAverageButton = UIButton()
    
    var gradesEnteredArray : [String] = []
    var gradesShownArray : [UILabel] = []
    
    var gradesRowNumber = 0
    var gradesColumnNumber = 1
    
    enum Grade : String {
        case FourPlus = "4+"
        case Four = "4"
        case FourMinus = "4-"
        case ThreePlus = "3+"
        case Three = "3"
        case ThreeMinus = "3-"
        case TwoPlus = "2+"
        case Two = "2"
        case TwoMinus = "2-"
        case OnePlus = "1+"
        case One = "1"
        case OneMinus = "1-"
        case R = "R"
        case NE = "NE"
    }
    
    @objc func convertGradeToPercent(gradeSent : String) -> Int {
        // convert grade level to percentage
        var gradeNumber = 0
        if gradeSent == "NE" {
            gradeNumber = 0
        } else if gradeSent == "R" {
            gradeNumber = 40
        } else if gradeSent == "1-" {
            gradeNumber = 51
        } else if gradeSent == "1" {
            gradeNumber = 55
        } else if gradeSent == "1+" {
            gradeNumber = 58
        } else if gradeSent == "2-" {
            gradeNumber = 61
        } else if gradeSent == "2" {
            gradeNumber = 64
        } else if gradeSent == "2+" {
            gradeNumber = 68
        } else if gradeSent == "3-" {
            gradeNumber = 71
        } else if gradeSent == "3" {
            gradeNumber = 74
        } else if gradeSent == "3+" {
            gradeNumber = 78
        } else if gradeSent == "4-" {
                gradeNumber = 83
        } else if gradeSent == "4" {
            gradeNumber = 91
        } else if gradeSent == "4+" {
            gradeNumber = 97
        } else {
            answerLabel.text = "Invalid level."
        }
        
            return gradeNumber
    }
    
    @objc func enterClicked() {
        // check if a valid grade was entered
        if let gradeEntered = Grade(rawValue: gradeLevelTextField.text!) {
            // convert input from type Grade to String
            let gradeLevelEntered = String(gradeEntered.rawValue)
            
            // add level to array
            gradesEnteredArray.append(gradeLevelEntered)
            
            // check if a new column is needed to show levels, so levels dont go off bottom of the screen
            if gradesEnteredArray.count > 15 {
                if gradesEnteredArray.count > 30 {
                    // set variable to multiply x postions of grade labels; make new column
                    gradesColumnNumber = 3
                    // set variable to subtract from y postion of grade labels; reset row from the top
                    gradesRowNumber = 600 
                }
                // set variable to multiply x postions of grade labels; make new column
                gradesColumnNumber = 2
                // set variable to subtract from y postion of grade labels; reset row from the top
                gradesRowNumber = 300
            }
            
            // show level entered under previously entered level
            let gradeLabel = UILabel()
            gradeLabel.text = gradeLevelEntered
            view.addSubview(gradeLabel)
            gradeLabel.translatesAutoresizingMaskIntoConstraints = false
            gradeLabel.topAnchor.constraint(equalTo: getAverageButton.bottomAnchor, constant: CGFloat(20 * gradesEnteredArray.count - gradesRowNumber)).isActive = true
            gradeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(20 * gradesColumnNumber)).isActive = true
            gradesShownArray.append(gradeLabel)
        } else {
            answerLabel.text = "Please enter a valid grade level."
        }
    }
    
    @objc func getAverageClicked() {
        // check if any grades are entered
        if gradesEnteredArray.count >= 1 {
            // create local temporary variables for this function
            var levelAsPercent : Int = 0
            var sumOfMarks : Int = 0
            
            // get sum of all marks entered
            for counter in 1 ... gradesEnteredArray.count {
                levelAsPercent = convertGradeToPercent(gradeSent: gradesEnteredArray[counter - 1])
                sumOfMarks += levelAsPercent
            }
            
            // calculate and show average
            let totalAverage = sumOfMarks / gradesEnteredArray.count
            answerLabel.text = "Your average is \(String(totalAverage))%"
        } else {
            answerLabel.text = "Please enter a grade level."
        }
    }
    
    @objc func removeLastClicked() {
        // check if there is any grade to remove
        if gradesEnteredArray.count >= 1 {
            // remove grade from grade array
            gradesEnteredArray.removeLast()
            
            // remove last grade shown on screen from view and array
            gradesShownArray[gradesShownArray.count - 1].removeFromSuperview()
            gradesShownArray.removeLast()
            
        } else {
            answerLabel.text = "There are no grades left to remove."
        }
    }
    
    override func viewDidLoad() {
        // UI
        super.viewDidLoad()
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view = view
        
        instructionLabel.text = "Enter your grade level."
        view.addSubview(instructionLabel)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        gradeLevelTextField.borderStyle = UITextBorderStyle.roundedRect
        gradeLevelTextField.placeholder = "Enter level"
        view.addSubview(gradeLevelTextField)
        gradeLevelTextField.translatesAutoresizingMaskIntoConstraints = false
        gradeLevelTextField.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20).isActive = true
        gradeLevelTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        enterButton.setTitle("Enter", for: .normal)
        enterButton.setTitleColor(.blue, for: .normal)
        enterButton.titleLabel?.textAlignment = .center
        enterButton.addTarget(self, action: #selector(enterClicked), for: .touchUpInside)
        view.addSubview(enterButton)
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10).isActive = true
        enterButton.leadingAnchor.constraint(equalTo: gradeLevelTextField.trailingAnchor, constant: 75).isActive = true
        
        removeLastButton.setTitle("Remove last level", for: .normal)
        removeLastButton.setTitleColor(.blue, for: .normal)
        removeLastButton.titleLabel?.textAlignment = .center
        removeLastButton.addTarget(self, action: #selector(removeLastClicked), for: .touchUpInside)
        view.addSubview(removeLastButton)
        removeLastButton.translatesAutoresizingMaskIntoConstraints = false
        removeLastButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 10).isActive = true
        removeLastButton.centerXAnchor.constraint(equalTo: enterButton.centerXAnchor, constant: 0).isActive = true
        
        getAverageButton.setTitle("Get average", for: .normal)
        getAverageButton.setTitleColor(.blue, for: .normal)
        getAverageButton.titleLabel?.textAlignment = .center
        getAverageButton.addTarget(self, action: #selector(getAverageClicked), for: .touchUpInside)
        view.addSubview(getAverageButton)
        getAverageButton.translatesAutoresizingMaskIntoConstraints = false
        getAverageButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 10).isActive = true
        getAverageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        answerLabel.text = nil
        view.addSubview(answerLabel)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.topAnchor.constraint(equalTo: removeLastButton.bottomAnchor, constant: 20).isActive = true
        answerLabel.centerXAnchor.constraint(equalTo: removeLastButton.centerXAnchor, constant: 0).isActive = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

// this will be commented out when code moved to Xcode
PlaygroundPage.current.liveView = ViewController()
