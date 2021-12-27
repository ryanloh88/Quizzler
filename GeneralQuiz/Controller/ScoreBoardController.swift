//
//  scoreBoard.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 7/11/21.
//

import Foundation
import UIKit
import Firebase
class ScoreBoardController : UIViewController{
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        
        
        if calculateFinal() > 80 {
            scoreLabel.text = "You got \(String(format: "%.1f", calculateFinal()))%, congrats, you are smart!"
        }else if calculateFinal() > 60{
            scoreLabel.text = "You got \(String(format: "%.1f", calculateFinal()))%, you alright"
        }else if calculateFinal() > 45 {
            scoreLabel.text = "You got \(String(format: "%.1f", calculateFinal()))%, you're coming in close eh"
        }else{
            scoreLabel.text = "You got \(String(format: "%.1f", calculateFinal()))%, try harder next time!"
        }
        endQuiz()
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
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
