//
//  ViewController.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 7/10/21.
//

import UIKit
import Firebase
class QuestionController: UIViewController {
    @IBOutlet weak var questionNumLabel: UILabel!
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var typeAnswer: UILabel!
    
    @IBOutlet weak var answerField: UITextField!
    
    @IBOutlet weak var checkAnswerLabel: UILabel!
    
    @IBOutlet weak var startQuiz: UIButton!
    //multiple choice buttons
    
    @IBOutlet weak var choiceA: UIButton!
    
    @IBOutlet weak var choiceB: UIButton!
    
    @IBOutlet weak var choiceC: UIButton!
    
    @IBOutlet weak var choiceD: UIButton!
    
    @IBOutlet weak var submitPressed: UIButton!
    var currentNumOfQn = 1
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        answerField.delegate = self
        choiceA.isHidden = true
        choiceB.isHidden = true
        choiceC.isHidden = true
        choiceD.isHidden = true
        checkAnswerLabel.isHidden = true
        
        
        //Until I figure out a way to use the textfield
        typeAnswer.isHidden = true
        answerField.isHidden = true
        submitPressed.isHidden = true
        
        
    }
    
    
    
    @IBAction func startQuiz(_ sender: UIButton) {
        
        questionNumLabel.text = "Question \(currentNumOfQn) out of \(quizBrain.numOfCurrentQn)"
        print("yp\(quizBrain.numOfCurrentQn)")
        startQuiz.isHidden = true 
        quizBrain.changeQuestion()
        QuestionLabel.text = quizBrain.getQuestionText()
        setChoices()
        choiceA.isHidden = false
        choiceB.isHidden = false
        choiceC.isHidden = false
        choiceD.isHidden = false
        
    }
    
    @IBAction func LogOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        currentNumOfQn += 1
        questionNumLabel.text = "Question \(currentNumOfQn) out of \(quizBrain.numOfCurrentQn)"
        showAnswer(answer: sender.currentTitle!)
    }
    
    
    
    func showAnswer(answer: String){
        if quizBrain.checkAnswer(answer: answer.lowercased()) == true{
            checkAnswerLabel.text = "You are correct"
            quizBrain.score += 1
        }else{
            checkAnswerLabel.text = "You are wrong, the answer is \(quizBrain.getAnswerText())"
        }
        ScoreLabel.text = "Score: \(quizBrain.score)"
        checkAnswerLabel.isHidden = false
        quizBrain.changeQuestion()
        QuestionLabel.text = quizBrain.getQuestionText()
        setChoices()
    }
    func setChoices(){
        var index = 0
        var previousNumbers:[Int] = []
        while index <= 3 {
            var theNum = Int.random(in: 0...3)
            while previousNumbers.contains(theNum){
                theNum = Int.random(in: 0...3)
            }
            switch index {
            case 0:
                choiceA.setTitle(quizBrain.getChoices(choice: theNum), for: .normal)
            case 1:
                choiceB.setTitle(quizBrain.getChoices(choice: theNum), for: .normal)
            case 2:
                choiceC.setTitle(quizBrain.getChoices(choice: theNum), for: .normal)
            case 3:
                choiceD.setTitle(quizBrain.getChoices(choice: theNum), for: .normal)
            default:
                fatalError("nani")
            }
            index += 1
            previousNumbers.append(theNum)
        }
    }
}
extension QuestionController: UITextFieldDelegate{
    
    @IBAction func submitPressed(_ sender: UIButton) {
        answerField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if answerField.text != ""{
            return true
        }else{
            answerField.placeholder = "Type in an answer"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        showAnswer(answer: answerField.text!)
        answerField.placeholder = ""
        answerField.text = ""
    }
}
