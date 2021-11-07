//
//  RegisterViewController.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 13/10/21.
//

import Foundation
import UIKit
import Firebase


class RegisterViewController:UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        //step 1 in making user database
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
                if let e = error{
                    self.errorLabel.text = "There was an error authenticating your account: \(e.localizedDescription)"
                    return
                }else{
                    self.performSegue(withIdentifier: "goToCategory", sender: self)
//                 
                }
            }
        }
        
        
        
        
    }
}
