//
//  TutorialRecipeCell.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-16.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class TutorialRecipeCell: UITableViewCell {
  
  @IBOutlet weak var profileImageView: UIImageView! {
    didSet { profileImageView.circle() }
  }
  @IBOutlet weak var recipeImageView: UIImageView! {
    didSet { recipeImageView.addCornerRafius() }
  }
  @IBOutlet weak var beforeImageView: UIImageView! {
    didSet { beforeImageView.addCornerRafius() }
  }
  @IBOutlet weak var afterImageView: UIImageView! {
    didSet { afterImageView.addCornerRafius() }
  }
  @IBOutlet weak var recipeImageView1: UIImageView! {
    didSet { recipeImageView1.addCornerRafius() }
  }
  @IBOutlet weak var recipeImageView2: UIImageView! {
    didSet { recipeImageView2.addCornerRafius() }
  }
  @IBOutlet weak var recipeImageView3: UIImageView! {
    didSet { recipeImageView3.addCornerRafius() }
  }
  @IBOutlet weak var recipeImageView4: UIImageView! {
    didSet { recipeImageView4.addCornerRafius() }
  }
  @IBOutlet weak var recipeImageView5: UIImageView! {
    didSet { recipeImageView5.addCornerRafius() }
  }
  @IBOutlet weak var recipeImageView6: UIImageView! {
    didSet { recipeImageView6.addCornerRafius() }
  }
  
  @IBOutlet weak var procedureView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

fileprivate extension UIView {
  func circle() {
    layer.cornerRadius = frame.size.width / 2
    clipsToBounds = true
  }
  func addCornerRafius() {
    layer.cornerRadius = 10
    clipsToBounds = true
  }
}
