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
}

extension TutorialUserCell {
  
  func setupContens(_ user: User, index: Int) {
    rankingImage.image = getRankingImage(index: index)
    profileImage.image = UIImage(named: user.image)
    nameLabel.text = user.name
  }
  
  private func getRankingImage(index: Int) -> UIImage? {
    switch index {
    case 0:
      return UIImage(named: "ranking1")
    case 1:
      return UIImage(named: "ranking2")
    case 2:
      return UIImage(named: "ranking3")
    default:
      return UIImage()
    }
    
  }
}
