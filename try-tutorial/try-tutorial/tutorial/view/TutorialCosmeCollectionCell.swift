//
//  TutorialCosmeCollectionCell.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class TutorialCosmeCollectionCell: UICollectionViewCell {
  
  @IBOutlet weak var ranking_label: UILabel!
  @IBOutlet weak var ranking_image: UIImageView!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var brand_name: UILabel!
  @IBOutlet weak var cosme_name: UILabel!
  @IBOutlet weak var price: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
