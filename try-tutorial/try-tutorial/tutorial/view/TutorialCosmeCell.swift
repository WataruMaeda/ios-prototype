//
//  TutorialCosmeCell.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-14.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class TutorialCosmeCell: UICollectionViewCell {

  @IBOutlet weak var categoryImageView: UIImageView!
  @IBOutlet weak var recipeImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var detailsLabel: UILabel!
  @IBOutlet weak var recipeImageView1: UIImageView!
  @IBOutlet weak var recipeImageView2: UIImageView!
  @IBOutlet weak var recipeImageView3: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
}

extension TutorialCosmeCell {
  
  func setupContents(_ recipe: Recipe) {
    categoryImageView.image = UIImage(named: recipe.category)
    recipeImageView.image = UIImage(named: recipe.image)
    titleLabel.text = recipe.title
    recipeImageView1.image = UIImage(named: recipe.cosme_image_1)
    recipeImageView2.image = UIImage(named: recipe.cosme_image_2)
    recipeImageView3.image = UIImage(named: recipe.cosme_image_3)
    profileImageView.image = UIImage(named: "tuto-user-1")
    nameLabel.text = "ゆきだるま☃"
    
    // set favorite num / like num
    let deteilString = "  \(recipe.like)   \(recipe.save)"
    let attrString = NSMutableAttributedString(string: deteilString)
    
    // set like img
    let attach1 = NSTextAttachment()
    attach1.image = #imageLiteral(resourceName: "good_label")
    attach1.bounds = CGRect(x: 0,
                            y: -3,
                            width: frame.size.width * 0.12,
                            height: frame.size.width * 0.12)
    let attrString1 = NSAttributedString(attachment: attach1)
    attrString.insert(attrString1, at: 1)
    
    // set favorite img
    let attach2 = NSTextAttachment()
    attach2.image = #imageLiteral(resourceName: "favorite_label")
    attach2.bounds = CGRect(x: 0,
                            y: -3,
                            width: frame.size.width * 0.12,
                            height: frame.size.width * 0.12)
    let attrString2 = NSAttributedString(attachment: attach1)
    attrString.insert(attrString2, at: 7)
    
    detailsLabel.attributedText = attrString
  }
}
