//
//  CategoryNewController.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 7/12/21.
//

import Foundation
import UIKit
class CategoryNewController : UIViewController{
    
    @IBOutlet var collectionView: UICollectionView!
 
    override func viewDidLoad() {
        
        self.title = "Choose a category"
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout()
        let height = (view.frame.size.height) * 0.4
        let width = (view.frame.size.width) * 0.4
        layout.itemSize = CGSize(width: height, height: width)
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func setDelay(){
        let loadAlert = UIAlertController(title: nil, message: "Grabbing coffee..", preferredStyle: .alert)
        present(loadAlert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            loadAlert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "goToQuestion", sender: self)
        }
    }
    
    
}


extension CategoryNewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
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
extension CategoryNewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = quizBrain.quizCategories[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell

        cell.configure(with: UIImage(named: message)!, with: message.firstUppercased)
        print(message)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizBrain.quizCategories.count
    }
    
    
    
}

extension CategoryNewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.size.height) * 0.35
        let width = (view.frame.size.width) * 0.45
        
        return CGSize(width: width, height: height)
    }
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    

}
extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

