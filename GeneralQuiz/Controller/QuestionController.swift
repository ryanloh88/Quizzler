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
    
    @IBOutlet weak var endQuizLabel: UIButton!
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
        navigationItem.hidesBackButton = true
        answerField.delegate = self
        hideButtons()
        checkAnswerLabel.isHidden = true
        
        
        typeAnswer.isHidden = true
        answerField.isHidden = true
        submitPressed.isHidden = true
        
        
        
    }
    
    func hideButtons(){
        choiceA.isHidden = true
        choiceB.isHidden = true
        choiceC.isHidden = true
        choiceD.isHidden = true
        ScoreLabel.isHidden = true
        questionNumLabel.isHidden = true
        QuestionLabel.isHidden = true
        endQuizLabel.isHidden = true
        
    }
    
    @IBAction func startQuiz(_ sender: UIButton) {
        
        questionNumLabel.text = "Question \(currentNumOfQn) out of \(quizBrain.numOfCurrentQn)"
        print("yp\(quizBrain.numOfCurrentQn)")
        startQuiz.isHidden = true
        ScoreLabel.isHidden = false
        questionNumLabel.isHidden = false
        QuestionLabel.isHidden = false
        endQuizLabel.isHidden = false
        quizBrain.changeQuestion()
        QuestionLabel.text = quizBrain.getQuestionText()
        setChoices()
      
        ScoreLabel.text = "Score: 0"
        
    }
    
    
    @IBAction func LogOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        
            let loadAlert = UIAlertController(title: nil, message: "Are you sure you want to Log out?", preferredStyle: .alert)
            loadAlert.addAction(UIAlertAction(title: "Log out", style: .default, handler: { (action) in
                do{
                    quizBrain.reset()
                    try firebaseAuth.signOut()
                    self.navigationController?.popToRootViewController(animated: true)
                } catch let signOutError as NSError {
                    print("Error signing out: %@", signOutError)
                }
            }))
            loadAlert.addAction(UIAlertAction(title: "Stay", style: .default, handler: { (action) in
                loadAlert.dismiss(animated: true, completion: nil)
            }))
        present(loadAlert, animated: true, completion: nil)
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
    
        currentNumOfQn += 1
        questionNumLabel.text = "Question \(currentNumOfQn) out of \(quizBrain.numOfCurrentQn)"
        showAnswer(answer: sender.currentTitle!)
    }
    
    
    @IBAction func leavePressed(_ sender: UIButton) {
        let loadAlert = UIAlertController(title: nil, message: "Are you sure you want to leave? your current progress would not be saved.", preferredStyle: .alert)
        loadAlert.addAction(UIAlertAction(title: "Leave", style: .default, handler: { (action) in
            quizBrain.reset()
            self.performSegue(withIdentifier: "goToCategory", sender: self)
        }))
        loadAlert.addAction(UIAlertAction(title: "Stay", style: .default, handler: { (action) in
            loadAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(loadAlert, animated: true, completion: nil)
        
        
        
    }
    
    func showAnswer(answer: String){
        if quizBrain.checkAnswer(answer: answer.lowercased()) == true{
            checkAnswerLabel.text = "You are correct"
            quizBrain.score += 1
        }else{
            checkAnswerLabel.text = "You are wrong, the answer is \(quizBrain.getAnswerText())"
        }
        ScoreLabel.text = "Score: \(quizBrain.score)"
        choiceC.isHidden = false
        choiceD.isHidden = false
        checkAnswerLabel.isHidden = false
        quizBrain.changeQuestion()
        QuestionLabel.text = quizBrain.getQuestionText()
        setChoices()
        if currentNumOfQn > quizBrain.numOfCurrentQn {
            hideButtons()
            QuestionLabel.isHidden = true
            questionNumLabel.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                
                self.endQuiz()
            }
        }
        
    }
    func setChoices(){
        var index = 0
        var previousNumbers:[Int] = []
        
        choiceA.isHidden = false
        choiceB.isHidden = false
        if quizBrain.getType() == "multiple"{
            choiceC.isHidden = false
            choiceD.isHidden = false
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
        if quizBrain.getType() == "boolean"{
            choiceC.isHidden = true
            choiceD.isHidden = true
            choiceA.setTitle("True", for: .normal)
            choiceB.setTitle("False", for: .normal)
            
        }
  
    }
    func endQuiz(){
        
        self.performSegue(withIdentifier: "goToScore", sender: self)
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
