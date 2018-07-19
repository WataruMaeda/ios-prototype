//
//  TutorialUserCell
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class TutorialUserCell: UICollectionViewCell {
  
  @IBOutlet weak var rankingImage: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var officialImage: UIImageView!
  @IBOutlet weak var rankingLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setupContens() {
    
  }
}
