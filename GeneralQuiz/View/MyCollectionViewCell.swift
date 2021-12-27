//
//  MyCollectionViewCell.swift
//  GeneralQuiz
//
//  Created by Ryan Loh Yong Rui on 7/12/21.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "MyCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image:UIImage, with text:String){
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        imageView.image = image
        categoryText.text = text
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }

}
