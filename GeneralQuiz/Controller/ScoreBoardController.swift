//
//  scoreBoard.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 7/11/21.
//

import Foundation
import UIKit
class ScoreBoardController : UIViewController{
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        
        print(calculateFinal())
        if calculateFinal() > 80 {
            scoreLabel.text = "You got \(calculateFinal())%, congrats, you are smart!"
        }else if calculateFinal() > 60{
            scoreLabel.text = "You got \(calculateFinal())%, you alright"
        }else if calculateFinal() > 45 {
            scoreLabel.text = "You got \(calculateFinal())%, you're coming in close eh"
        }else{
            scoreLabel.text = "You got \(calculateFinal())%, you stupid or dumb?"
        }
        endQuiz()
    }
    func calculateFinal() -> Float{
        let totalQnNum = Float(quizManager.getNum(diff: quizManager.currentDiff.diff))
        let totalScore = Float(quizBrain.score)
        return (Float(totalScore)/totalQnNum) * 100
    }
    
    func endQuiz(){
        quizBrain.reset()
    }
    
  
    
    @IBAction func homeMenuPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToCategory", sender: self)
    }
    
}
