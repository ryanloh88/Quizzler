//
//  LoginViewController.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 13/10/21.
//

import Foundation
import UIKit
import Firebase
let quizBrain = QuizBrain()
let quizManager = QuizManager()

class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.errorLabel.text="Error Logging into your account: \(e)"
                }else{
                    self.performSegue(withIdentifier: "goToCategory", sender: self)            
                }
                
            }
        }
        
    }
}
