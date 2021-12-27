//
//  CategoryViewController.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 13/10/21.
//

import Foundation
import UIKit


class CategoryViewController :UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        //        navigationController?.navigationBar.backgroundColor = UIColor.white
        
        //        navigationController.
    }
    func setDelay(){
        let loadAlert = UIAlertController(title: nil, message: "Grabbing coffee..", preferredStyle: .alert)
        present(loadAlert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            loadAlert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "goToQuestion", sender: self)
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = quizBrain.quizCategories[indexPath.row].uppercased()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = message
        return cell!
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizBrain.quizCategories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loadAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        present(loadAlert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            loadAlert.dismiss(animated: true, completion: nil)
            
            let message = quizBrain.quizCategories[indexPath.row]
            
            let category = quizBrain.quizCategory[message]
            
            quizManager.fetchAmount(cat: category!)
            //creating an alert function
            
            let alert = UIAlertController(title: "Choose your difficulty", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Easy", style: .default, handler: { (action) in
                quizManager.fetchQuiz(category: category!, difficulty: "easy")
                self.setDelay()
            }))
            alert.addAction(UIAlertAction(title: "Medium", style: .default, handler: { (action) in
                
                quizManager.fetchQuiz(category: category!, difficulty: "medium")
                self.setDelay()
            }))
            alert.addAction(UIAlertAction(title: "Hard", style: .default, handler: { (action) in
                
                quizManager.fetchQuiz(category: category!, difficulty: "hard")
                self.setDelay()
            }))
            alert.addAction(UIAlertAction(title: "Any", style: .default, handler: { (action) in
                quizManager.fetchQuiz(category: category!, difficulty: "")
                self.setDelay()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}



